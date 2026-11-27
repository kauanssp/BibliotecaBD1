-- DML - UPDATE e DELETE com conferências.
-- Execute após as consultas do arquivo 04, somente com dados de teste.

-- M01. Corrigir individualmente o nome do leitor B002.
SELECT matricula, nome FROM leitor WHERE matricula = 'B002';

UPDATE leitor
SET nome = 'Bruno Prado Lima'
WHERE matricula = 'B002';

SELECT matricula, nome FROM leitor WHERE matricula = 'B002';

-- M02. Corrigir o nome da editora em vários cadastros.
SELECT id_livro, titulo, editora FROM livro
WHERE editora IN ('Editora Horizonte', 'Horizonte Acadêmica')
ORDER BY id_livro;

UPDATE livro
SET editora = 'Horizonte Acadêmica'
WHERE editora = 'Editora Horizonte';

SELECT id_livro, titulo, editora FROM livro
WHERE editora IN ('Editora Horizonte', 'Horizonte Acadêmica')
ORDER BY id_livro;

-- M03. Prorrogar em três dias os empréstimos em aberto.
SELECT id_emprestimo, data_prevista_devolucao FROM emprestimo
WHERE data_efetiva_devolucao IS NULL
ORDER BY id_emprestimo;

UPDATE emprestimo
SET data_prevista_devolucao = data_prevista_devolucao + 3
WHERE data_efetiva_devolucao IS NULL;

SELECT id_emprestimo, data_prevista_devolucao FROM emprestimo
WHERE data_efetiva_devolucao IS NULL
ORDER BY id_emprestimo;

-- M04. Remover o histórico encerrado de T-005 para demonstrar a dependência.
SELECT emprestimo.id_emprestimo, emprestimo.data_efetiva_devolucao
FROM emprestimo INNER JOIN exemplar USING (id_exemplar)
WHERE exemplar.codigo_tombo = 'T-005';

DELETE FROM emprestimo
USING exemplar
WHERE emprestimo.id_exemplar = exemplar.id_exemplar
  AND exemplar.codigo_tombo = 'T-005'
  AND emprestimo.data_efetiva_devolucao IS NOT NULL;

SELECT emprestimo.id_emprestimo, emprestimo.data_efetiva_devolucao
FROM emprestimo INNER JOIN exemplar USING (id_exemplar)
WHERE exemplar.codigo_tombo = 'T-005';

-- M05. Excluir a cópia T-005 após a remoção do vínculo em M04.
SELECT id_exemplar, codigo_tombo FROM exemplar WHERE codigo_tombo = 'T-005';

DELETE FROM exemplar
WHERE codigo_tombo = 'T-005';

SELECT id_exemplar, codigo_tombo FROM exemplar WHERE codigo_tombo = 'T-005';

-- M06. Excluir o cadastro B005 apenas se ele não tem histórico.
SELECT id_leitor, matricula FROM leitor WHERE matricula = 'B005';

DELETE FROM leitor
WHERE matricula = 'B005'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimo WHERE emprestimo.id_leitor = leitor.id_leitor
  );

SELECT id_leitor, matricula FROM leitor WHERE matricula = 'B005';
