-- Table: alumnado.padron

-- DROP TABLE IF EXISTS alumnado.padron;

CREATE TABLE IF NOT EXISTS alumnado.padron
(
    cueanexo integer NOT NULL DEFAULT nextval('alumnado.padron_cueanexo_seq'::regclass),
    id_jurisdiccion integer,
    id_sector integer,
    id_ambito integer,
    id_departamento integer,
    id_localidad integer,
    nombre character varying COLLATE pg_catalog."default",
    domicilio character varying COLLATE pg_catalog."default",
    id_cod_postal integer,
    telefono character varying(50) COLLATE pg_catalog."default",
    mail character varying COLLATE pg_catalog."default",
    CONSTRAINT padron_pkey PRIMARY KEY (cueanexo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS alumnado.padron
    OWNER to postgres;