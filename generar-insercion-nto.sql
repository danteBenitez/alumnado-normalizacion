DO $$
DECLARE
	query_var character varying := '';
BEGIN
	FOR quarter IN 1.. 3 LOOP 
    	FOR note_idx IN 0.. 6 LOOP
			IF query_var != '' THEN
				query_var = query_var || ' UNION ';
			END IF;
			query_var = query_var || 'SELECT 
	nextval(''serial''),
    id_periodo_materia_alumno,
    "trimestre'|| quarter ||'[' || note_idx || ']"::double precision as nota
  FROM alumnado.periodo_materia_alumno tpmatal
    JOIN alumnado.padron_oferta_alumno tpofalu
        USING(id_padron_oferta_alumno)
    JOIN alumnado.alumnos talumnos
        USING(id_alumno)
   JOIN alumnado.alumno_plan talumno_plan
		ON talumno_plan.id_alumno = talumnos.id_alumno
		AND talumno_plan.año = tpofalu.año
    JOIN alumnado.materias tmaterias
        USING(id_plan)
    JOIN alumnado.padron_oferta tpadron_oferta
        USING(id_padron_oferta)
    JOIN alumnado.notas_csv tnotas_csv
        ON 
            CAST(tnotas_csv."_id.dni" AS INTEGER) = talumnos.dni AND
            tmaterias.codigo_materia = CONCAT(tnotas_csv."_id.plan", tnotas_csv."_id.anio_que_cursa", tnotas_csv."_id.materia_nro") AND
            CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER) = tpofalu.año
    WHERE id_tipo_periodo = 1 AND nro_periodo = ' || quarter;
		END LOOP;
	END LOOP;
	
	RAISE NOTICE '%', query_var;
END $$;

-- Rehacer inserción de notas
-- Aviso: Tanto padron_oferta_alumno como alumno_plan 
-- tienen un campo año que debe coincidir con el de las notas
SELECT 
    *
  FROM alumnado.periodo_materia_alumno tpmatal
    JOIN alumnado.padron_oferta_alumno tpofalu
        USING(id_padron_oferta_alumno)
    JOIN alumnado.alumnos talumnos
        USING(id_alumno)
	JOIN alumnado.alumno_plan talumno_plan
		ON talumno_plan.id_alumno = talumnos.id_alumno
		AND talumno_plan.año = tpofalu.año
	JOIN alumnado.plan tplan
		USING(id_plan)
	JOIN alumnado.materias tmaterias
		USING(id_plan)
    JOIN alumnado.notas_csv tnotas_csv
        ON 
            CAST(tnotas_csv."_id.dni" AS INTEGER) = talumnos.dni AND
            tmaterias.codigo_materia = CONCAT(tnotas_csv."_id.plan", tnotas_csv."_id.anio_que_cursa", tnotas_csv."_id.materia_nro") AND
            CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER) = tpofalu.año AND
			tnotas_csv."_id.anio_que_cursa"::integer = tpofalu.grado
	
    WHERE id_tipo_periodo = 1 AND "trimestre1[0]" IS NOT NULL AND nro_periodo = 1

