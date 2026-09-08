# agent-utils

Markdowns, skills, rules e prompts de base para agentes de IA nos meus projetos.

## Como usar

Copie a pasta do stack para dentro do projeto alvo, em `docs/` (ou onde o
projeto guardar documentação), e aponte o `AGENTS.md` / `CLAUDE.md` da raiz do
projeto para ela.

```bash
cp -r agent-utils/frontend/angular meu-projeto/docs/angular
```

Os documentos se referenciam por caminho relativo entre si, então mova a pasta
inteira — nunca arquivos soltos.

## Conteúdo

### `frontend/angular/` — Angular 22+

| Arquivo | Papel |
| --- | --- |
| `AGENTS.md` | Regras operacionais do agente: o que ler, o que rodar, o que é proibido |
| `arquitetura.md` | Fonte única de estrutura de pastas, APIs modernas, escopo do RxJS e coesão |
| `qualidade.md` | Definition of Done e critérios de rejeição em code review |
| `prompts/refactor.md` | Template de pedido para quebrar componente inflado |

Ordem de leitura para o agente: `AGENTS.md` → `arquitetura.md` → `qualidade.md`.
