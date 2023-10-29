DROP TABLE IF EXISTS alumnado.padron_oferta;

CREATE TABLE alumnado.padron_oferta
(
    id_padron_oferta serial NOT NULL,
    cueanexo integer,
    id_oferta integer,
    PRIMARY KEY (id_padron_oferta)
);

ALTER TABLE IF EXISTS alumnado.padron_oferta
    OWNER to postgres;

DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

INSERT INTO alumnado.padron_oferta (
    id_padron_oferta,
    cueanexo,
    id_oferta
)
    SELECT
        nextval('serial'),
        tpadron.cueanexo,
        101
    FROM alumnado.padron_csv tpadron_csv
    JOIN alumnado.padron tpadron ON tpadron_csv.cueanexo = tpadron.cueanexo
    WHERE tpadron_csv.ec_jar = 1
    UNION 
    SELECT
        nextval('serial'),
        tpadron.cueanexo,
        102
    FROM alumnado.padron_csv tpadron_csv
    JOIN alumnado.padron tpadron ON tpadron_csv.cueanexo = tpadron.cueanexo
    WHERE tpadron_csv.ec_pri = 1
    UNION 
    SELECT 
        nextval('serial'),
        tpadron.cueanexo,
        110
    FROM alumnado.padron_csv tpadron_csv
    JOIN alumnado.padron tpadron ON tpadron_csv.cueanexo = tpadron.cueanexo
    WHERE tpadron_csv.ec_sec = 1
    UNION
    SELECT 
        nextval('serial'),
        tpadron.cueanexo,
        115
    FROM alumnado.padron_csv tpadron_csv
    JOIN alumnado.padron tpadron ON tpadron_csv.cueanexo = tpadron.cueanexo
    WHERE tpadron_csv.ec_snu = 1;

UPDATE alumnado.padron_oferta SET id_oferta = (
    SELECT id_oferta FROM alumnado.oferta toferta WHERE toferta.oferta_nro = alumnado.padron_oferta.id_oferta 
);