-- La colección incluye alumnos que estudian 
-- una oferta no disponible en el establecimiento en el que lo hacen
-- Esto hace que la inserción a padron_oferta_alumno esté incompleta
-- porque significa que hay alumnos en alumnos_csv que no pueden
-- conseguir una referencia válida a padron_oferta.
SELECT *
FROM ALUMNADO.ALUMNOs
WHERE ID_ALUMNO NOT IN
		(SELECT 
				ID_ALUMNO
				
			FROM ALUMNADO.ALUMNOS TALUMNOS
			JOIN ALUMNADO.ALUMNOS_CSV TALUMNOS_CSV ON TALUMNOS.DNI = CAST(TALUMNOS_CSV._ID AS INTEGER)
			JOIN ALUMNADO.PADRON_OFERTA TPADRON_OFERTA ON CAST(TALUMNOS_CSV.OFERTA2022 AS INTEGER) =
				(SELECT OFERTA_NRO
					FROM ALUMNADO.OFERTA TOFERTA
					WHERE TOFERTA.ID_OFERTA = TPADRON_OFERTA.ID_OFERTA )
			AND CAST(TALUMNOS_CSV."CUE2022" AS INTEGER) = TPADRON_OFERTA.CUEANEXO);

-- Existen notas cuyo añio_que_cursa entra en contradicción
-- con los años estudiados por el alumno al que pertenecen.
-- La siguiente consulta serializa las entradas de la consulta
-- que se utilizaría para insertar las notas o períodos,
-- y revela qué DNI's entran en conflicto como se ha mencionado.
SELECT *
FROM
	(SELECT CONCAT("_id.dni",

										"_id.anio_lectivo",
										"_id.plan",
										"_id.anio_que_cursa",
										"_id.materia_nro")
		FROM ALUMNADO.NOTAS_CSV) S where concat NOT IN
	(SELECT CONCAT("_id.dni",

										"_id.anio_lectivo",
										"_id.plan",
										"_id.anio_que_cursa",
										"_id.materia_nro") AS TEXT2
		FROM
			(SELECT *
				FROM ALUMNADO.NOTAS_CSV TNOTAS_CSV
				JOIN ALUMNADO.ALUMNOS TALUMNO ON TALUMNO.DNI = CAST(TNOTAS_CSV."_id.dni" AS INTEGER)
				JOIN ALUMNADO.ALUMNOS_CSV TALUMNOS_CSV ON TALUMNO.DNI = CAST(TALUMNOS_CSV._ID AS INTEGER)
				JOIN ALUMNADO.MATERIAS TMATERIA ON CONCAT(TNOTAS_CSV."_id.plan",

																																								TNOTAS_CSV."_id.anio_que_cursa",
																																								TNOTAS_CSV."_id.materia_nro") = TMATERIA.CODIGO_MATERIA
				JOIN ALUMNADO.PLAN TPLAN ON TNOTAS_CSV."_id.plan" = CAST(TPLAN.CODIGO_PLAN AS CHARACTER varying)
				JOIN ALUMNADO.PADRON_OFERTA_ALUMNO TPOFALUM ON TPOFALUM.ID_ALUMNO = TALUMNO.ID_ALUMNO
				AND CAST(TNOTAS_CSV."_id.anio_lectivo" AS INTEGER) = TPOFALUM.año
				JOIN ALUMNADO.PADRON_OFERTA TPOFERTA USING(ID_PADRON_OFERTA)
				WHERE "_id.cuatrimestre_que_cursa" IS NULL
					AND ((TNOTAS_CSV."_id.plan" = TALUMNOS_CSV."plan2021"
											AND TNOTAS_CSV."_id.anio_lectivo" = '2021')
										OR (TNOTAS_CSV."_id.plan" = TALUMNOS_CSV."plan2022"
														AND TNOTAS_CSV."_id.anio_lectivo" = '2022'))));
