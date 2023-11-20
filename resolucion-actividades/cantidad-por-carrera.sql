SELECT
	tplan.descripcion AS "Carrera",
	COUNT(id_alumno) as "Cantidad de alumnos"
	FROM alumnado.alumno_plan talplan
	JOIN alumnado.plan tplan
		USING(id_plan)
	WHERE 
		talplan.año = 2021 AND
		tplan.descripcion LIKE '%Tecnicatura Superior en Desarrollo de Software Multiplataforma%'
	GROUP BY tplan.descripcion