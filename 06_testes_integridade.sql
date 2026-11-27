-- Testes de integridade. Execute um INSERT de cada vez.

-- T01. Matrícula duplicada. Esperado: UNIQUE, SQLSTATE 23505.
INSERT INTO leitor (nome, matricula)
VALUES ('Leitor de Teste', 'B001');

-- T02. Livro inexistente. Esperado: FOREIGN KEY, SQLSTATE 23503.
INSERT INTO exemplar (id_livro, codigo_tombo)
VALUES (-1, 'T-TESTE-FK');

-- T03. Ausência de título. Esperado: NOT NULL, SQLSTATE 23502.
INSERT INTO livro (titulo, editora, ano_publicacao)
VALUES (NULL, 'Editora de Teste', 2022);

-- T04. Devolução anterior à retirada. Esperado: CHECK, SQLSTATE 23514.
INSERT INTO emprestimo (id_exemplar, id_leitor, data_retirada,
                        data_prevista_devolucao, data_efetiva_devolucao)
VALUES ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-006'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B001'),
        DATE '2026-11-25', DATE '2026-12-02', DATE '2026-11-24');
