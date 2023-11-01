CREATE SEQUENCE notas_csv_seq START 1;

CREATE TABLE alumnado.notas_csv
(
    "_id.dni" character varying NOT NULL,
    "_id.anio_lectivo" character varying NOT NULL ,
    "_id.plan" character varying NOT NULL,
    "_id.anio_que_cursa" character varying ,
    "_id.materia_nro" character varying,
    "trimestre1[0]" character varying,
    "trimestre1[1]" character varying,
    "trimestre1[2]" character varying,
    "trimestre1[3]" character varying,
    "trimestre1[4]" character varying,
    "trimestre1[5]" character varying,
    "trimestre1[6]" character varying,
    "trimestre2[0]" character varying,
    "trimestre2[1]" character varying,
    "trimestre2[2]" character varying,
    "trimestre2[3]" character varying,
    "trimestre2[4]" character varying,
    "trimestre2[5]" character varying,
    "trimestre2[6]" character varying,
    "trimestre3[0]" character varying,
    "trimestre3[1]" character varying,
    "trimestre3[2]" character varying,
    "trimestre3[3]" character varying,
    "trimestre3[4]" character varying,
    "trimestre3[5]" character varying,
    "trimestre3[6]" character varying,
    "_id.cuatrimestre_que_cursa" character varying,
    "notas_del_cuetrimestre[0]" character varying,
    "notas_del_cuetrimestre[1]" character varying,
    "notas_del_cuetrimestre[2]" character varying,
    "notas_del_cuetrimestre[3]" character varying,
    "notas_del_cuetrimestre[4]" character varying,
    "notas_del_cuetrimestre[5]" character varying,
    "notas_del_cuetrimestre[6]" character varying
);

ALTER TABLE IF EXISTS alumnado.periodo_materia_alumno
    OWNER to postgres;