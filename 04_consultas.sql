-- DQL - Consultas sobre a carga inicial do arquivo 03.
-- Data de referência das consultas de atraso e disponibilidade: 27/11/2026.

-- Q01. Quais empréstimos estão em aberto e vencidos na data de referência?
SELECT id_emprestimo, id_exemplar, data_prevista_devolucao
FROM emprestimo
WHERE data_efetiva_devolucao IS NULL
  AND data_prevista_devolucao < DATE '2026-11-27'
ORDER BY data_prevista_devolucao, id_emprestimo;

-- Q02. Quais títulos contêm a palavra "dados"?
SELECT id_livro, titulo, editora
FROM livro
WHERE titulo ILIKE '%dados%'
ORDER BY titulo;

-- Q03. Quais livros foram publicados entre 2020 e 2023?
SELECT titulo, ano_publicacao
FROM livro
WHERE ano_publicacao BETWEEN 2020 AND 2023
ORDER BY ano_publicacao, titulo;

-- Q04. Quais leitores têm as matrículas B001 ou B003?
SELECT nome, matricula
FROM leitor
WHERE matricula IN ('B001', 'B003')
ORDER BY matricula;

-- Q05. Quais foram as três retiradas mais recentes?
SELECT id_emprestimo, id_exemplar, data_retirada
FROM emprestimo
ORDER BY data_retirada DESC, id_emprestimo DESC
LIMIT 3;

-- Q06. Quais livros e exemplares o leitor B001 retirou e quando os devolveu?
SELECT livro.titulo, exemplar.codigo_tombo, emprestimo.data_retirada,
       emprestimo.data_efetiva_devolucao
FROM emprestimo
INNER JOIN leitor ON leitor.id_leitor = emprestimo.id_leitor
INNER JOIN exemplar ON exemplar.id_exemplar = emprestimo.id_exemplar
INNER JOIN livro ON livro.id_livro = exemplar.id_livro
WHERE leitor.matricula = 'B001'
ORDER BY emprestimo.data_retirada, emprestimo.id_emprestimo;

-- Q07. A qual título pertence cada exemplar cadastrado?
SELECT exemplar.codigo_tombo, livro.titulo
FROM exemplar
INNER JOIN livro ON livro.id_livro = exemplar.id_livro
ORDER BY exemplar.codigo_tombo;

-- Q08. Quais leitores nunca fizeram um empréstimo?
SELECT leitor.nome, leitor.matricula
FROM leitor
LEFT JOIN emprestimo ON emprestimo.id_leitor = leitor.id_leitor
WHERE emprestimo.id_emprestimo IS NULL
ORDER BY leitor.matricula;

-- Q09. Quais livros tiveram mais empréstimos em novembro de 2026?
SELECT livro.titulo, COUNT(*) AS quantidade_emprestimos
FROM livro
INNER JOIN exemplar ON exemplar.id_livro = livro.id_livro
INNER JOIN emprestimo ON emprestimo.id_exemplar = exemplar.id_exemplar
WHERE emprestimo.data_retirada >= DATE '2026-11-01'
  AND emprestimo.data_retirada < DATE '2026-12-01'
GROUP BY livro.id_livro, livro.titulo
ORDER BY quantidade_emprestimos DESC, livro.titulo;

-- Q10. Qual foi a duração média, em dias, das retiradas concluídas de cada leitor?
SELECT leitor.matricula, leitor.nome,
       ROUND(AVG(emprestimo.data_efetiva_devolucao - emprestimo.data_retirada), 2)
           AS duracao_media_dias
FROM leitor
INNER JOIN emprestimo ON emprestimo.id_leitor = leitor.id_leitor
WHERE emprestimo.data_efetiva_devolucao IS NOT NULL
GROUP BY leitor.id_leitor, leitor.matricula, leitor.nome
ORDER BY leitor.matricula;

-- Q11. Quais edições têm pelo menos dois exemplares?
SELECT livro.titulo, COUNT(*) AS quantidade_exemplares
FROM livro
INNER JOIN exemplar ON exemplar.id_livro = livro.id_livro
GROUP BY livro.id_livro, livro.titulo
HAVING COUNT(*) >= 2
ORDER BY quantidade_exemplares DESC, livro.titulo;

-- Q12. Quais exemplares estão disponíveis na carga inicial?
SELECT exemplar.codigo_tombo, livro.titulo
FROM exemplar
INNER JOIN livro ON livro.id_livro = exemplar.id_livro
WHERE NOT EXISTS (
    SELECT 1
    FROM emprestimo
    WHERE emprestimo.id_exemplar = exemplar.id_exemplar
      AND emprestimo.data_efetiva_devolucao IS NULL
)
ORDER BY livro.titulo, exemplar.codigo_tombo;
