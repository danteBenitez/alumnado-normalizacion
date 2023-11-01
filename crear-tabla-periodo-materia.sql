CREATE SEQUENCE periodo_materia_alumno_seq START 1;

CREATE TABLE alumnado.periodo_materia_alumno
(
    id_periodo_materia_alumno integer NOT NULL DEFAULT nextval('periodo_materia_alumno_seq'),
    id_padron_oferta_alumno integer NOT NULL,
    id_materia integer NOT NULL,
    nro_trimestre integer NOT NULL,
    PRIMARY KEY (id_periodo_materia_alumno)
);

ALTER TABLE IF EXISTS alumnado.periodo_materia_alumno
    OWNER to postgres;

