# Instruções para Agentes de IA

Este repositório possui regras arquiteturais estritas. Como um agente de IA operando nesta base de código, você está proibido de ignorar estas diretrizes em favor de "soluções rápidas" ou padrões genéricos de tutoriais.

**Versão mínima do projeto: Angular 22.** Todas as APIs citadas abaixo assumem essa versão.

## 1. Fluxo de Trabalho Obrigatório

- **Leia antes de escrever:** Antes de implementar uma nova feature ou refatorar um componente, você DEVE ler os documentos irmãos deste arquivo: [`arquitetura.md`](arquitetura.md) e [`qualidade.md`](qualidade.md).
- **Planejamento:** Para alterações complexas (novas telas, refatorações pesadas), liste a árvore de componentes e a estratégia de estado que você pretende criar ANTES de gerar o código final. Peça aprovação do usuário.
- **Verificação Pós-Código:** Após alterar o código, você deve executar lint, testes unitários afetados e o build de desenvolvimento. Nunca conclua uma tarefa deixando o build ou os testes quebrados.

  ```bash
  npm run lint
  npm run test
  ng build --configuration development
  ```

  Se o projeto usa outros nomes de script, confirme no `package.json` antes de rodar.

## 2. Limites e Restrições

- **Zero adivinhação de API:** O frontend consome contratos estritos. Se você não tem certeza do payload de uma API, peça para ver o Swagger/OpenAPI ou a tipagem do backend em vez de inferir ou usar `any`.
- **Sem regressão de dívida:** Você não tem permissão para adicionar responsabilidades novas a componentes que já estão inflados. Se pedirem para adicionar algo a um "mega-componente", você deve primeiro extrair a nova funcionalidade para um componente próprio.
- **Uso estrito de ferramentas:** Você NÃO deve inventar dependências, instalar bibliotecas não autorizadas ou ignorar a biblioteca de UI base do projeto (ex: criar um select customizado em vez de usar o do design system).
- **Build é permitido, deploy não:** `ng build --configuration development` é obrigatório para validar tipagem de template (`strictTemplates`), que lint e teste não cobrem. Já build de produção, publicação e qualquer comando de deploy exigem pedido explícito do usuário.

## 3. Padrão Tecnológico Inegociável

- Use APENAS Angular Moderno: Standalone, Control Flow (`@if`, `@for`), `inject()`, `input()`, `output()` e `Signals`.
- RxJS tem escopo fechado, definido em [`arquitetura.md`](arquitetura.md#rxjs--observables). Fora dele, use Signals.
