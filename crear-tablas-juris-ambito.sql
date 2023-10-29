-- DROP TABLE IF EXISTS alumnado.barrio;

CREATE TABLE IF NOT EXISTS alumnado.jurisdiccion
(
    id_jurisdiccion integer NOT NULL DEFAULT nextval('alumnado.jurisdiccion_id_jurisdiccion_seq'::regclass),
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT jurisdiccion_pkey PRIMARY KEY (id_jurisdiccion)
);


CREATE TABLE IF NOT EXISTS alumnado.sector
(
    id_sector integer NOT NULL DEFAULT nextval('alumnado.sector_id_sector_seq'::regclass),
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT sector_pkey PRIMARY KEY (id_sector)
);


CREATE TABLE IF NOT EXISTS alumnado.ambito
(
    id_ambito integer NOT NULL DEFAULT nextval('alumnado.ambito_id_ambito_seq'::regclass),
    descripcion character varying COLLATE pg_catalog."default",
    CONSTRAINT ambito_pkey PRIMARY KEY (id_ambito)
);

CREATE TABLE IF NOT EXISTS alumnado.departamento
(
    id_departamento integer NOT NULL DEFAULT nextval('alumnado.departamento_id_departamento_seq'::regclass),
    nombre character varying COLLATE pg_catalog."default",
    codigo_departamento character varying COLLATE pg_catalog."default",
    CONSTRAINT departamento_pkey PRIMARY KEY (id_departamento)
);

CREATE TABLE IF NOT EXISTS alumnado.codigo_postal
(
    id_codigo_postal integer NOT NULL DEFAULT nextval('alumnado.codigo_postal_id_codigo_postal_seq'::regclass),
    codigo character varying(15) COLLATE pg_catalog."default",
    CONSTRAINT codigo_postal_pkey PRIMARY KEY (id_codigo_postal)
);

CREATE TABLE IF NOT EXISTS alumnado.localidad
(
    id_localidad integer NOT NULL DEFAULT nextval('alumnado.localidad_id_localidad_seq'::regclass),
    nombre character varying(40) COLLATE pg_catalog."default",
    codigo_localidad bigint,
    id_departamento integer NOT NULL,
    CONSTRAINT localidad_pkey PRIMARY KEY (id_localidad)
)

TABLESPACE pg_default;
