# Biblioteca universitária — requisitos preliminares

## Tema e escopo

Uma biblioteca universitária fictícia precisa saber quais exemplares estão disponíveis, quais estão emprestados e quais devoluções estão atrasadas. O atendente registra livros, exemplares e leitores, além das retiradas e devoluções. A coordenação consulta a situação do acervo e o histórico de circulação. O projeto usará somente dados fictícios. Multas, reservas e renovações ficam fora do escopo.

O cadastro de **Livro** representa uma edição e guarda identificador, título, editora e ano de publicação. **Exemplar** representa uma cópia física e guarda identificador e código de tombo. **Leitor** guarda identificador, nome e matrícula. **Empréstimo** guarda identificador, data de retirada, data prevista e data efetiva de devolução.

## Regras de negócio

- **RN01** — Livro, Exemplar, Leitor e Empréstimo têm identificadores próprios. Título, editora, ano de publicação, código de tombo, nome, matrícula, data de retirada e data prevista de devolução são obrigatórios em seus respectivos cadastros.
- **RN02** — Um livro pode ter de zero a muitos exemplares. Cada exemplar pertence a exatamente um livro.
- **RN03** — Cada exemplar tem um código de tombo único. Cada leitor tem uma matrícula única.
- **RN04** — Um leitor pode ter de zero a muitos empréstimos. Cada empréstimo pertence a exatamente um leitor.
- **RN05** — Um exemplar pode ter de zero a muitos empréstimos ao longo do tempo. Cada empréstimo se refere a exatamente um exemplar.
- **RN06** — Um exemplar pode ter, no máximo, um empréstimo em aberto. A devolução efetiva fica vazia até a entrega. Um exemplar está disponível quando não tem empréstimo em aberto.
- **RN07** — A data prevista de devolução deve ser igual ou posterior à retirada. Quando preenchida, a data efetiva também deve ser igual ou posterior à retirada.
- **RN08** — Um livro com exemplares cadastrados não pode ser excluído. A exclusão de leitores e exemplares com histórico de empréstimo também é impedida para preservar as referências.

## Perguntas que orientam as consultas

1. Quais exemplares estão disponíveis e a quais livros pertencem?
2. Quais empréstimos em aberto estão atrasados na data de referência?
3. Quais empréstimos um leitor fez e quando devolveu cada exemplar?
4. Quais leitores ainda não realizaram nenhum empréstimo?
5. Quais livros tiveram mais empréstimos no período consultado?
