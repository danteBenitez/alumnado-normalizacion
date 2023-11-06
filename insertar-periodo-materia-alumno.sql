DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

DELETE FROM alumnado.periodo_materia_alumno;

INSERT INTO alumnado.periodo_materia_alumno (
    id_periodo_materia_alumno,
    id_padron_oferta_alumno,
    id_materia,
    nro_trimestre
) SELECT 
    nextval('serial'),
    id_padron_oferta_alumno,
    id_materia,
    nro_trimestre
  FROM alumnado.notas_csv tnotas_csv
  JOIN alumnado.padron_oferta_alumno 
