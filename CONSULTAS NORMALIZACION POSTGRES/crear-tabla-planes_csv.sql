-- Table: alumnado.planes_csv

DROP TABLE IF EXISTS alumnado.planes_csv;

CREATE TABLE IF NOT EXISTS alumnado.planes_csv
(
    _id character varying COLLATE pg_catalog."default",
    carrera character varying COLLATE pg_catalog."default",
    fplan date,
    anios integer,
    "cantimaterias[0]" character varying COLLATE pg_catalog."default",
    "cantimaterias[1]" character varying COLLATE pg_catalog."default",
    "cantimaterias[2]" character varying COLLATE pg_catalog."default",
    "cantimaterias[3]" character varying COLLATE pg_catalog."default",
    "cantimaterias[4]" character varying COLLATE pg_catalog."default",
    "cantimaterias[5]" character varying COLLATE pg_catalog."default",
	"Resol" character varying COLLATE pg_catalog."default",
    cuatrimestres character varying COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS alumnado.planes_csv
    OWNER to postgres;