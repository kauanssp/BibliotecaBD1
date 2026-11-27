-- DML - Carga inicial da biblioteca
-- No banco biblioteca, execute um comando por vez, na ordem do arquivo.

-- 1. Cadastrar os livros fictícios.
INSERT INTO livro (titulo, editora, ano_publicacao)
VALUES ('Noções de Banco de Dados', 'Editora Horizonte', 2021),
       ('Introdução à Programação', 'Editora Horizonte', 2023),
       ('Algoritmos em Prática', 'Editora Ponto Norte', 2020),
       ('Redes de Computadores', 'Editora Ponto Norte', 2019),
       ('Fundamentos de Engenharia', 'Editora Vale', 2024);

-- 2. Cadastrar os exemplares. Os IDs dos livros são consultados no banco.
INSERT INTO exemplar (id_livro, codigo_tombo)
VALUES ((SELECT id_livro FROM livro WHERE titulo = 'Noções de Banco de Dados'), 'T-001'),
       ((SELECT id_livro FROM livro WHERE titulo = 'Noções de Banco de Dados'), 'T-002'),
       ((SELECT id_livro FROM livro WHERE titulo = 'Introdução à Programação'), 'T-003'),
       ((SELECT id_livro FROM livro WHERE titulo = 'Algoritmos em Prática'), 'T-004'),
       ((SELECT id_livro FROM livro WHERE titulo = 'Redes de Computadores'), 'T-005'),
       ((SELECT id_livro FROM livro WHERE titulo = 'Fundamentos de Engenharia'), 'T-006');

-- 3. Cadastrar os leitores fictícios. B005 ficará sem empréstimos.
INSERT INTO leitor (nome, matricula)
VALUES ('Ana Lira', 'B001'),
       ('Bruno Prado', 'B002'),
       ('Carla Siqueira', 'B003'),
       ('Daniel Mota', 'B004'),
       ('Elisa Barros', 'B005');

-- 4. Registrar empréstimos devolvidos e em aberto.
INSERT INTO emprestimo (id_exemplar, id_leitor, data_retirada,
                        data_prevista_devolucao, data_efetiva_devolucao)
VALUES ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-001'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B001'),
        DATE '2026-11-02', DATE '2026-11-09', DATE '2026-11-07'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-002'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B002'),
        DATE '2026-11-03', DATE '2026-11-10', DATE '2026-11-09'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-003'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B003'),
        DATE '2026-11-04', DATE '2026-11-11', DATE '2026-11-10'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-004'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B001'),
        DATE '2026-11-06', DATE '2026-11-13', DATE '2026-11-12'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-005'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B004'),
        DATE '2026-11-08', DATE '2026-11-15', DATE '2026-11-14'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-001'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B002'),
        DATE '2026-11-10', DATE '2026-11-17', DATE '2026-11-18'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-003'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B003'),
        DATE '2026-11-12', DATE '2026-11-19', DATE '2026-11-16'),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-002'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B004'),
        DATE '2026-11-16', DATE '2026-11-23', NULL),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-004'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B001'),
        DATE '2026-11-21', DATE '2026-11-28', NULL),
       ((SELECT id_exemplar FROM exemplar WHERE codigo_tombo = 'T-003'),
        (SELECT id_leitor FROM leitor WHERE matricula = 'B002'),
        DATE '2026-11-25', DATE '2026-12-02', NULL);
