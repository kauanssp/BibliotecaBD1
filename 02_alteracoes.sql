-- DDL - Alterações da estrutura.
-- Executar uma única vez, após 01_estrutura.sql e antes da carga inicial.

-- Amplia o campo para aceitar códigos de tombo mais longos.
ALTER TABLE exemplar
    ALTER COLUMN codigo_tombo TYPE VARCHAR(30);

-- A data de devolução é opcional enquanto o empréstimo está em aberto.
ALTER TABLE emprestimo
    ADD CONSTRAINT ck_emprestimo_data_efetiva
        CHECK (
            data_efetiva_devolucao IS NULL
            OR data_efetiva_devolucao >= data_retirada
        );
