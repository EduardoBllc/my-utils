# Padrão de Arquitetura Base

**Versão mínima: Angular 22.**

## Estrutura e Aliases

- **Diretórios Base:**
  - `pages/` ou `features/`: Componentes associados a rotas (Smart Components).
  - `shared/`: Componentes, pipes e utilitários genuinamente reutilizáveis entre domínios.
  - `services/`: Acesso a dados, integrações HTTP e estado compartilhado.
  - `ui/`: Primitivas do design system (ex: Spartan NG, Angular Material, etc).

- **Aninhamento Visual:** Componentes filhos exclusivos de um contexto devem ficar **dentro** da pasta do componente pai. Mova para `shared/` apenas se houver reutilização real.
- **Imports Absolutos:** É estritamente proibido usar imports relativos longos (`../../../`). O projeto deve configurar e utilizar aliases no `tsconfig.json` (`@app/`, `@components/`, `@shared/`).

## Modernidade Angular

- **APIs Modernas:** O projeto adota componentes `standalone`. O uso de `NgModule` é proibido em código novo.
- **Injeção de Dependência:** Use exclusivamente a função `inject()` no lugar de construtores.
- **Inputs/Outputs:** Use os signals baseados em `input()` e `output()` no lugar dos decorators clássicos (`@Input`/`@Output`).
- **Templates:** O controle de fluxo nativo (`@if`, `@for`, `@switch`) é o padrão. As diretivas estruturais legadas (`*ngIf`, `*ngFor`, `*ngSwitch`) são proibidas.
- **Gerenciamento de Estado:** **Signals** são a escolha primária.
  - Estado derivado: use `computed()`.
  - Atualizações: use `set()` ou `update()`.

### RxJS / Observables

Escopo fechado. RxJS é permitido **apenas** para:

1. Chamadas HTTP (`HttpClient`).
2. Eventos globais do browser (`resize`, `scroll`, `storage`, atalhos de teclado).
3. Composição de streams que dependem de tempo ou cancelamento (`debounceTime`, `switchMap`, `takeUntil`).

Fora desses três casos, use Signals. Todo Observable que alimenta a interface deve ser convertido na fronteira com a UI (`toSignal()`); templates não consomem Observable via `async` em código novo.

## Coesão e Separação de Componentes (A Regra de Ouro)

Esta seção é a fonte única sobre coesão. `qualidade.md` aplica estes critérios como gate de merge, mas não os redefine.

- Todo componente deve ter uma responsabilidade principal explicável em uma frase curta.
- **Quando extrair um subcomponente?** Quando a região do código apresentar:
  - Estado, interação ou validação próprios;
  - Ciclo assíncrono independente (ex: seu próprio loading/error state);
  - Lógica condicional ou de formatação que pertence apenas àquela região;
  - Necessidade de ser testada em isolamento sem afetar a página inteira.

- Uma região que atenda a qualquer um dos critérios acima é considerada **autônoma** e deve virar componente próprio.
- Tamanho de arquivo sozinho não justifica a extração se resultar em um componente passivo que apenas espelha a API do pai.
