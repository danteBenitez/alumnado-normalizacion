-- Table: alumnado.materias

DROP TABLE IF EXISTS alumnado.materias;

CREATE TABLE IF NOT EXISTS alumnado.materias
(
    id_materia integer NOT NULL DEFAULT nextval('alumnado.materias_id_materia_seq'::regclass),
    nombre character varying,
    id_plan integer,
	codigo_materia character varying,
    CONSTRAINT materias_pkey PRIMARY KEY (id_materia)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS alumnado.materias
    OWNER to postgres;