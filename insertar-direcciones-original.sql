DROP SEQUENCE IF EXISTS serial;

CREATE
TEMPORARY SEQUENCE serial
START 1;

INSERT INTO alumnado.direccion_1 (id_direccion1, calle, nro, id_alumno)
SELECT nextval('serial'),
       "domicilio.calle",
       "domicilio.numero",
       id_alumno
FROM alumnado.alumnos_csv talumnos_csv
JOIN alumnado.alumnos talumnos ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
WHERE id_tipo_barrio = 1;

DROP SEQUENCE IF EXISTS serial1;

CREATE
TEMPORARY SEQUENCE serial1
START 1;

INSERT INTO alumnado.direccion_2 (id_direccion2, manzana, casa, id_alumno)
SELECT nextval('serial1'),
       "domicilio.manzana",
       "domicilio.casa",
       id_alumno
FROM alumnado.alumnos_csv talumnos_csv
JOIN alumnado.alumnos talumnos ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
WHERE id_tipo_barrio = 2;


DROP SEQUENCE IF EXISTS serial2;

CREATE
TEMPORARY SEQUENCE serial2
START 1;

INSERT INTO alumnado.direccion_3 (id_direccion3, sector, manzana, casa, id_alumno)
SELECT nextval('serial2'),
       "domicilio.sector",
       "domicilio.manzana",
       "domicilio.casa",
       id_alumno
FROM alumnado.alumnos_csv talumnos_csv
JOIN alumnado.alumnos talumnos ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
WHERE id_tipo_barrio = 3;


DROP SEQUENCE IF EXISTS serial3;

CREATE
TEMPORARY SEQUENCE serial3
START 1;

INSERT INTO alumnado.direccion_4 (id_direccion4, torre, departamento, id_alumno)
SELECT nextval('serial3'),
       "domicilio.torre",
       "domicilio.departamento",
       id_alumno
FROM alumnado.alumnos_csv talumnos_csv
JOIN alumnado.alumnos talumnos ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
WHERE id_tipo_barrio = 4;