## Explicações

- Em vez de explicações muito detalhadas, prefira ir direto ao ponto de maneira clara e simples. Quando
  for necessário uma explicação detalhada primeiro dê um resumo direto, claro e simples, e depois detalhe.
  Do contrário, só apresente explicações detalhadas quando solicitado para aprofundar ou detalhar algo.

## Uso do Superpowers

- Use o fluxo de spec e plano do Superpowers somente em trabalhos elaborados, como mudancas grandes,
  refatoracoes ou novas features.
- Para correcoes pequenas, ajustes pontuais e tarefas que nao impactam diretamente a aplicacao,
  como prototipos visuais, implemente e verifique diretamente, sem criar spec ou plano.

## Aprovacao de specs

- Ao apresentar uma spec para aprovacao, a opcao padrao deve ser aprovar e implementar com
  subagentes em uma worktree isolada, fazendo merge na `main` ao finalizar a implementacao.
- Nao apresente a escolha principal como "subagentes ou inline". Ofereca o fluxo padrao acima ou a
  possibilidade de eu escolher manualmente outro modo de implementacao.

## Estilo de codigo

- Conjunto fechado de valores vira enum SEMPRE. Nunca magic number nem magic string solta no meio
  do codigo — nem em comparacao, nem em default, nem em parametro de teste.

## Comentários no código

- **Comentário só onde o código não pode falar:** uma decisão que teve alternativa, uma restrição de fora (legado, constraint do banco, bug de biblioteca) ou uma armadilha que parece bug. Nunca mais longo que o código que explica, e nunca repetindo o que o nome já diz. Vale para docstring também: uma linha, salvo quando o módulo inteiro precisa de contexto que não cabe no nome dele.
