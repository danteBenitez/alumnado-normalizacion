DROP SEQUENCE IF EXISTS tipo_periodo_seq;
CREATE SEQUENCE tipo_periodo_seq START 1;

DROP TABLE IF EXISTS alumnado.tipo_periodo;

CREATE TABLE alumnado.tipo_periodo
(
    id_tipo_periodo integer NOT NULL DEFAULT nextval('tipo_periodo_seq'),
    descripcion character varying NOT NULL,
    PRIMARY KEY (id_tipo_periodo)
);

ALTER TABLE IF EXISTS alumnado.tipo_periodo 
    OWNER to postgres;

INSERT INTO alumnado.tipo_periodo (descripcion)
    VALUES ('Trimestre'), ('Cuatrimestre')