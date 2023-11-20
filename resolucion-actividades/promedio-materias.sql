SELECT
	tmaterias.nombre as "Materia",
	AVG(tnotas.nota) AS "Promedio de notas",
	tpofal.año
	FROM alumnado.notas tnotas
	JOIN alumnado.periodo_materia_alumno tpmatal
		USING(id_periodo_materia_alumno)
	JOIN alumnado.tipo_periodo ttperiodo
		USING(id_tipo_periodo)
	JOIN alumnado.materias tmaterias
		USING(id_materia)
	JOIN alumnado.padron_oferta_alumno tpofal
		USING(id_padron_oferta_alumno)
	WHERE
		tmaterias.nombre LIKE '%Geografía%' AND
		nro_periodo = 3 AND 
		ttperiodo.descripcion LIKE '%Trimestre%'
	GROUP BY tpofal.año, tmaterias.nombre;