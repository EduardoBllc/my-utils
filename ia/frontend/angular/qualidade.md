# Padrões de Qualidade e Critérios de Aceite (DoD)

Este documento define quando o código produzido está **adequado para ser mergeado**. Um Pull Request ou uma entrega de agente de IA só é considerada finalizada se cumprir 100% dos critérios abaixo.

## 1. Definition of Done (Critérios de Aceite Globais)

Nenhum código entra na branch principal se falhar nos seguintes testes:

- [ ] **Semântica e Acessibilidade (A11y):** Elementos interativos usam tags nativas adequadas (`<button>`, `<a href>`). Navegação por teclado é possível. O foco é visível.
- [ ] **Estado Assíncrono:** Todas as chamadas de rede preveem e tratam explicitamente 3 estados na UI: Carregando (Loading), Vazio (Empty state) e Erro (Tratamento amigável).
- [ ] **Zero Erros de Tipagem:** O uso de `any` é estritamente proibido. Tipagens de payload de API devem corresponder exatamente aos contratos do backend.
- [ ] **Passa na CI Local:** Lint, formatação, testes unitários e `ng build --configuration development` executam sem erros ou warnings. O build é obrigatório: é ele que valida a tipagem de template (`strictTemplates`).

## 2. Critérios de Adequação de Componentes (Coesão)

Os critérios de coesão são definidos em [`arquitetura.md`](arquitetura.md#coesão-e-separação-de-componentes-a-regra-de-ouro). Esta seção apenas os aplica como gate de merge.

Um componente Angular é considerado **inadequado** e será rejeitado se:

1. **Acumular Responsabilidades:** Misturar o gerenciamento de chamadas HTTP/Store com regras visuais hiperespecíficas (ex: regras complexas de CSS e manipulação de formulários longos na mesma classe).
2. **Ignorar o Design System:** Recriar primitivas de UI (modais, tooltips, selects) do zero ou via HTML puro em vez de usar a biblioteca homologada do projeto.
3. **Template Monolítico:** Tiver um arquivo HTML que cresce a ponto de dificultar a leitura rápida, combinando múltiplas regiões que possuem lógicas independentes (ex: um componente que desenha a navbar, o painel lateral e a tabela de dados).

_Nota para refatoração e IA:_ Identificada uma violação, extraia a região autônoma. A definição de região autônoma está em [`arquitetura.md`](arquitetura.md#coesão-e-separação-de-componentes-a-regra-de-ouro).

## 3. Critérios de Adequação de Testes

Código com testes ruins é pior que código sem testes, pois gera falsa segurança.

- **Proibido testar implementação:** Testes não devem validar se o método `onClick()` foi chamado, mas sim se a ação disparada pelo botão refletiu a mudança esperada no estado (Signal) ou no DOM.
- **Proibido "Should Create" vazio:** O teste padrão gerado pela CLI do Angular (`it('should create')`) não contabiliza como cobertura útil.
- **Teste de Contrato de UI:** Componentes de apresentação (Dumb Components) devem ser testados garantindo que diferentes `input()` geram a renderização correta e que interações disparam os `output()` corretos.

## 4. Gestão de Dívida Técnica

- **A Regra do Escoteiro:** Alterações em componentes que já estão fora do padrão não exigem que o componente inteiro seja reescrito, **MAS** a nova funcionalidade exigida deve nascer isolada e em conformidade com as regras atuais.
- Dívidas técnicas pagas só são consideradas quitadas quando a duplicação ou o acoplamento forem eliminados fisicamente do repositório, garantindo que o lint e os testes passem na nova estrutura.
