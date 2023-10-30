-- Table: alumnado.materias_csv

DROP TABLE IF EXISTS alumnado.materias_csv;

CREATE TABLE IF NOT EXISTS alumnado.materias_csv
(
    _id character varying COLLATE pg_catalog."default" NOT NULL DEFAULT nextval('alumnado.materias_id_materia_csv_seq'::regclass),
    plan_id character varying COLLATE pg_catalog."default",
    espacio character varying COLLATE pg_catalog."default",
    CONSTRAINT materias_csv_pkey PRIMARY KEY (_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS alumnado.materias_csv
    OWNER to postgres;