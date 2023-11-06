DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

INSERT INTO alumnado.notas (
    id_nota,
    id_periodo_materia_alumno,
    nota,
) SELECT 
    nextval('serial'),
    id_periodo_materia_alumno,
    "trimestre1[0]"
  FROM alumnado.periodo_materia_alumno tpmatal
    JOIN alumnado.padron_oferta_alumno tpofalu
        USING(id_padron_oferta_alumno)
    JOIN alumnado.alumnos talumnos
        USING(id_alumno)
    JOIN alumnado.alumno_plan tplan_alumno 
        USING(id_alumno)
    JOIN alumnado.materias tmaterias
        USING(id_plan)
    JOIN alumnado.padron_oferta tpadron_oferta
        USING(id_padron_oferta)
    JOIN alumnado.notas_csv tnotas_csv
        ON 
            CAST(tnotas_csv."_id.dni" AS INTEGER) = talumnos.dni AND
            tmaterias.codigo_materia = CONCAT(tnotas_csv."_id.plan", tnotas_csv."_id.anio_que_cursa", tnotas_csv."_id.materia_nro") AND
            CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER) = tpofalu.año
    WHERE id_tipo_periodo = 1;
