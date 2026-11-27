-- DDL - Criação do banco e das tabelas.
-- Se o banco já existir, pule CREATE DATABASE.

\c postgres

CREATE DATABASE biblioteca;

\c biblioteca

CREATE TABLE livro
(
    id_livro INTEGER GENERATED ALWAYS AS IDENTITY,
    titulo TEXT NOT NULL,
    editora TEXT NOT NULL,
    ano_publicacao SMALLINT NOT NULL,
    PRIMARY KEY (id_livro),
    CONSTRAINT ck_livro_ano_publicacao
        CHECK (ano_publicacao BETWEEN 1 AND 9999)
);

CREATE TABLE exemplar
(
    id_exemplar INTEGER GENERATED ALWAYS AS IDENTITY,
    id_livro INTEGER NOT NULL,
    codigo_tombo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_exemplar),
    CONSTRAINT uq_exemplar_codigo_tombo UNIQUE (codigo_tombo),
    CONSTRAINT fk_exemplar_livro
        FOREIGN KEY (id_livro) REFERENCES livro (id_livro)
        ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE leitor
(
    id_leitor INTEGER GENERATED ALWAYS AS IDENTITY,
    nome TEXT NOT NULL,
    matricula VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_leitor),
    CONSTRAINT uq_leitor_matricula UNIQUE (matricula)
);

CREATE TABLE emprestimo
(
    id_emprestimo INTEGER GENERATED ALWAYS AS IDENTITY,
    id_exemplar INTEGER NOT NULL,
    id_leitor INTEGER NOT NULL,
    data_retirada DATE NOT NULL,
    data_prevista_devolucao DATE NOT NULL,
    data_efetiva_devolucao DATE,
    PRIMARY KEY (id_emprestimo),
    CONSTRAINT fk_emprestimo_exemplar
        FOREIGN KEY (id_exemplar) REFERENCES exemplar (id_exemplar)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT fk_emprestimo_leitor
        FOREIGN KEY (id_leitor) REFERENCES leitor (id_leitor)
        ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT ck_emprestimo_data_prevista
        CHECK (data_prevista_devolucao >= data_retirada)
);

-- Uma cópia pode voltar a ser emprestada depois da devolução.
CREATE UNIQUE INDEX uq_emprestimo_aberto_exemplar
    ON emprestimo (id_exemplar)
    WHERE data_efetiva_devolucao IS NULL;
