SELECT
	toferta.descripcion as "Nivel",
	tlocalidad.nombre as "Localidad",
	COUNT(id_alumno) as "Conteo de alumnos"
	FROM alumnado.padron_oferta_alumno tpofal
	JOIN alumnado.padron_oferta tpoferta
		USING(id_padron_oferta)
	JOIN alumnado.oferta toferta
		USING(id_oferta)
	JOIN alumnado.padron tpadron
		USING(cueanexo)
	JOIN alumnado.localidad tlocalidad
		USING(id_localidad)
	WHERE tpofal.año = 2021
	GROUP BY 
		tlocalidad.nombre,
		tlocalidad.id_localidad,
		toferta.descripcion,
		toferta.id_oferta
	ORDER BY toferta.id_oferta