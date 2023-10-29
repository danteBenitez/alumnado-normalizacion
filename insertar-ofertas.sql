DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

DROP TABLE IF EXISTS alumnado.padron_oferta_alumno;

CREATE TABLE alumnado.padron_oferta_alumno
(
    id_padron_oferta_alumno integer NOT NULL,
    id_padron_oferta integer NOT NULL,
    id_alumno integer, 
    año integer NOT NULL,
    grado integer NOT NULL,
    PRIMARY KEY (id_padron_oferta_alumno)
);

ALTER TABLE IF EXISTS alumnado.padron_oferta_alumno
    OWNER to postgres;

DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

-- Insertar en ofertas con año 2021
INSERT INTO alumnado.padron_oferta_alumno(
    id_padron_oferta_alumno,
    id_padron_oferta,
    id_alumno,
    año,
    grado
) SELECT nextval('serial'), id_padron_oferta, id_alumno, 2021, CAST(grado2021 AS INTEGER)
    FROM alumnado.alumnos talumnos
    JOIN alumnado.alumnos_csv talumnos_csv ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
    JOIN alumnado.padron_oferta 
        tpadron_oferta ON 
            CAST(talumnos_csv.oferta2021 AS INTEGER) = (
                SELECT oferta_nro 
				FROM alumnado.oferta toferta
                WHERE toferta.id_oferta = tpadron_oferta.id_oferta
            )
            AND CAST(talumnos_csv."CUE2021" AS INTEGER) = tpadron_oferta.cueanexo;

-- Insertar en ofertas con año 2022
INSERT INTO alumnado.padron_oferta_alumno (
    id_padron_oferta_alumno,
    id_padron_oferta,
    id_alumno,
    año,
	grado
) SELECT nextval('serial'), id_padron_oferta, id_alumno, 2022, CAST(grado2022 AS INTEGER)
    FROM alumnado.alumnos talumnos
    JOIN alumnado.alumnos_csv talumnos_csv ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
    JOIN alumnado.padron_oferta 
        tpadron_oferta ON 
            CAST(talumnos_csv.oferta2022 AS INTEGER) = (
                SELECT oferta_nro 
				FROM alumnado.oferta toferta
                WHERE toferta.id_oferta = tpadron_oferta.id_oferta
            )
            AND CAST(talumnos_csv."CUE2022" AS INTEGER) = tpadron_oferta.cueanexo;



