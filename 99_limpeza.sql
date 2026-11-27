-- DDL - LIMPEZA OPCIONAL E DESTRUTIVA.
-- Somente no banco biblioteca e apenas no ambiente de testes.
-- Confirme o banco com SELECT current_database(); antes de executar.
-- As tabelas são removidas da dependente para as referenciadas.

DROP TABLE IF EXISTS emprestimo;
DROP TABLE IF EXISTS exemplar;
DROP TABLE IF EXISTS leitor;
DROP TABLE IF EXISTS livro;
