-- Table: alumnado.alumnos

DROP TABLE IF EXISTS alumnado.alumnos;

CREATE TABLE IF NOT EXISTS alumnado.alumnos
(
    id_alumno integer NOT NULL DEFAULT nextval('alumnado.alumnos_id_alumno_seq'::regclass),
    dni integer NOT NULL,
    apellido character varying COLLATE pg_catalog."default",
    nombre character varying COLLATE pg_catalog."default",
    id_sexo integer NOT NULL,
    fecha_nacimiento date,
	id_barrio integer,
	id_tipo_barrio integer,
    id_nacionalidad integer NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS alumnado.alumnos
    OWNER to postgres;