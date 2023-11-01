CREATE SEQUENCE notas_seq START 1;

CREATE TABLE alumnado.notas
(
    id_nota integer NOT NULL DEFAULT nextval('notas_seq'),
    id_periodo_materia_alumno integer NOT NULL,
    nota FLOAT NOT NULL,
    PRIMARY KEY (id_nota)
);

ALTER TABLE IF EXISTS alumnado.periodo_materia_alumno
    OWNER to postgres;