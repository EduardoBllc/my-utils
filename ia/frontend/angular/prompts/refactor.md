# Prompt: Refatoração de Componente Inflado

Template para pedir a quebra de um componente que acumulou responsabilidades.
Substitua os campos `<...>` antes de enviar.

## Antes de enviar

- Confirme que o agente tem acesso a `AGENTS.md`, `arquitetura.md` e `qualidade.md`.
- Identifique a região autônoma a extrair pelos critérios da Regra de Ouro
  (estado próprio, ciclo assíncrono independente, lógica exclusiva da região,
  necessidade de teste isolado).

## Template

> O componente `<ComponentePai>` está inflado: mistura `<responsabilidade A>` com `<responsabilidade B>`.
> Refatore aplicando a separação de responsabilidades definida em `arquitetura.md`:
>
> 1. Crie o componente de apresentação `<ComponenteFilho>`, standalone, responsável apenas por `<o que ele exibe>`.
>    Ele recebe `<dados>` via `input()` e não faz chamada de API nem acessa store.
> 2. `<ComponenteFilho>` comunica interação ao pai via `output()` — um output por ação
>    (`<acaoA>`, `<acaoB>`), com payload tipado. Nada de `EventEmitter` declarado com `@Output()`.
> 3. Simplifique `<ComponentePai>` para renderizar `<ComponenteFilho>` dentro de `@for`,
>    mantendo nele apenas `<estado que permanece no pai>` e as chamadas de API.
> 4. Mantenha os três estados de UI (loading, vazio, erro) no nível onde o dado é carregado.
> 5. Adicione testes de contrato para `<ComponenteFilho>`: diferentes `input()` renderizam o
>    esperado e as interações emitem os `output()` corretos. `it('should create')` vazio não conta.
>
> Ao final, rode `npm run lint`, `npm run test` e `ng build --configuration development`.

## Exemplo preenchido

> O componente `BomboniereComponent` está inflado: mistura o estado do carrinho e as chamadas de API
> com o markup de cada item da lista. Refatore aplicando a separação de responsabilidades definida em `arquitetura.md`:
>
> 1. Crie o componente de apresentação `ItemCardComponent`, standalone, responsável apenas por exibir
>    foto, título, preço e os botões de incremento/decremento. Ele recebe `item` e `quantidade` via
>    `input()` e não faz chamada de API nem acessa store.
> 2. `ItemCardComponent` comunica interação ao pai via `output()` — `adicionar` e `remover`,
>    ambos com payload tipado. Nada de `EventEmitter` declarado com `@Output()`.
> 3. Simplifique `BomboniereComponent` para renderizar `app-item-card` dentro de `@for`,
>    mantendo nele apenas o estado geral do carrinho e as chamadas de API.
> 4. Mantenha os três estados de UI (loading, vazio, erro) no nível onde o dado é carregado.
> 5. Adicione testes de contrato para `ItemCardComponent`: diferentes `input()` renderizam o
>    esperado e as interações emitem os `output()` corretos. `it('should create')` vazio não conta.
>
> Ao final, rode `npm run lint`, `npm run test` e `ng build --configuration development`.
