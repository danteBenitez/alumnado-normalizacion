-- Crear secuencia temporal para claves primarias
DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE IF NOT EXISTS serial START 1;

DELETE FROM alumnado.jurisdiccion;

-- Insertar jurisdicciones
INSERT INTO alumnado.jurisdiccion (id_jurisdiccion, descripcion)
  VALUES (nextval('serial'), (SELECT DISTINCT juris FROM alumnado.padron_csv));

DROP SEQUENCE IF EXISTS serial_1;
CREATE TEMPORARY SEQUENCE IF NOT EXISTS serial_1 START 1;

DELETE FROM alumnado.sector;

INSERT INTO alumnado.sector (id_sector, descripcion)
    (
        SELECT nextval('serial_1'), sector FROM alumnado.padron_csv 
            GROUP BY sector
    );

DROP SEQUENCE IF EXISTS serial_2;
CREATE TEMPORARY SEQUENCE IF NOT EXISTS serial_2 START 1;

DELETE FROM alumnado.ambito;

INSERT INTO alumnado.ambito (id_ambito, descripcion)
    SELECT nextval('serial_2'), ambito FROM alumnado.padron_csv 
        GROUP BY ambito;

DROP SEQUENCE IF EXISTS serial_3;
CREATE TEMPORARY SEQUENCE IF NOT EXISTS serial_3 START 1;

DELETE FROM alumnado.departamento;

INSERT INTO alumnado.departamento (id_departamento, nombre, codigo_departamento)
    SELECT nextval('serial_3'), departamento, cod_depar FROM alumnado.padron_csv 
        GROUP BY departamento, cod_depar;


DROP SEQUENCE IF EXISTS serial_4;
CREATE TEMPORARY SEQUENCE IF NOT EXISTS serial_4 START 1;

DELETE FROM alumnado.codigo_postal;

INSERT INTO alumnado.codigo_postal (id_codigo_postal, codigo)
    SELECT nextval('serial_4'), cod_postal FROM alumnado.padron_csv 
        GROUP BY cod_postal;

DROP SEQUENCE IF EXISTS serial_5;
CREATE TEMPORARY SEQUENCE IF NOT EXISTS serial_5 START 1;

DELETE FROM alumnado.localidad;

INSERT INTO alumnado.localidad (id_localidad, nombre, codigo_localidad, id_departamento)
    SELECT nextval('serial_5'), localidad, cod_loca, (
        SELECT id_departamento FROM alumnado.departamento 
            WHERE alumnado.departamento.nombre = alumnado.padron_csv.departamento
    ) FROM alumnado.padron_csv 
        GROUP BY localidad, cod_loca, departamento;


