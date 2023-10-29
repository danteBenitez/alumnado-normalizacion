DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

DELETE FROM alumnado.oferta_alumno;

-- Insertar en ofertas con año 2021
INSERT INTO alumnado.oferta_alumno (
    id_oferta_alumno,
    id_alumno,
    id_oferta,
    año
) SELECT nextval('serial'), id_alumno, id_oferta, 2021
    FROM alumnado.alumnos talumnos
    JOIN alumnado.alumnos_csv talumnos_csv ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
    JOIN alumnado.oferta toferta ON CAST(talumnos_csv.oferta2021 AS INTEGER) = toferta.oferta_nro;

-- Insertar en ofertas con año 2022
INSERT INTO alumnado.oferta_alumno (
    id_oferta_alumno,
    id_alumno,
    id_oferta,
    año
) SELECT nextval('serial'), id_alumno, id_oferta, 2022
    FROM alumnado.alumnos talumnos
    JOIN alumnado.alumnos_csv talumnos_csv ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
    JOIN alumnado.oferta toferta ON CAST(talumnos_csv.oferta2022 AS INTEGER) = toferta.oferta_nro;



