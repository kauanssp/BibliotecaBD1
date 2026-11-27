# Modelo físico da biblioteca — PostgreSQL

O esquema guarda edições, cópias físicas, leitores e o histórico de empréstimos. Ele descreve a estrutura final, após os scripts 01 e 02.

## Dicionário de dados

### livro

- `id_livro` — Identificador da edição. `integer`, obrigatório, gerado por identidade `ALWAYS`. Chave primária.
- `titulo` — Título da edição. `text`, obrigatório, sem padrão.
- `editora` — Editora da edição. `text`, obrigatório, sem padrão.
- `ano_publicacao` — Ano de publicação. `smallint`, obrigatório, sem padrão. Deve estar entre 1 e 9999.

### exemplar

- `id_exemplar` — Identificador da cópia física. `integer`, obrigatório, gerado por identidade `ALWAYS`. Chave primária.
- `id_livro` — Edição à qual a cópia pertence. `integer`, obrigatório, sem padrão. Chave estrangeira para `livro(id_livro)`.
- `codigo_tombo` — Código da etiqueta da cópia. `varchar(30)`, obrigatório, sem padrão, único.

### leitor

- `id_leitor` — Identificador do leitor. `integer`, obrigatório, gerado por identidade `ALWAYS`. Chave primária.
- `nome` — Nome fictício do leitor. `text`, obrigatório, sem padrão.
- `matricula` — Matrícula fictícia. `varchar(30)`, obrigatória, sem padrão, única.

### emprestimo

- `id_emprestimo` — Identificador da movimentação. `integer`, obrigatório, gerado por identidade `ALWAYS`. Chave primária.
- `id_exemplar` — Cópia emprestada. `integer`, obrigatório, sem padrão. Chave estrangeira para `exemplar(id_exemplar)`.
- `id_leitor` — Leitor responsável pela retirada. `integer`, obrigatório, sem padrão. Chave estrangeira para `leitor(id_leitor)`.
- `data_retirada` — Data da retirada. `date`, obrigatória, sem padrão.
- `data_prevista_devolucao` — Prazo de devolução. `date`, obrigatória, sem padrão. Deve ser igual ou posterior à retirada.
- `data_efetiva_devolucao` — Data da entrega. `date`, opcional, com `NULL` implícito. Se preenchida, deve ser igual ou posterior à retirada.

## Relacionamentos e restrições

- Um livro pode ter vários exemplares. Cada exemplar referencia um livro.
- Um exemplar e um leitor podem ter vários empréstimos no histórico. Cada empréstimo referencia um exemplar e um leitor.
- As três chaves estrangeiras usam `ON DELETE RESTRICT` e `ON UPDATE RESTRICT` para impedir a exclusão ou a troca de identificadores referenciados e preservar o histórico.
- Um índice único parcial em `emprestimo(id_exemplar)`, aplicado às linhas com `data_efetiva_devolucao IS NULL`, garante apenas um empréstimo em aberto por exemplar. A disponibilidade é calculada pela ausência desse empréstimo.
- O script 02 amplia o código de tombo de 20 para 30 caracteres e acrescenta a validação da data efetiva. O dicionário já mostra o resultado das duas alterações.
