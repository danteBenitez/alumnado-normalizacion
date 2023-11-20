SELECT * FROM
(SELECT 
	tdepar.nombre as "Departamento",
	COUNT(id_alumno) as "Promovidos de secundaria (2021)"
	FROM alumnado.alumnos_promociones tpromovidos
	JOIN alumnado.alumnos talumnos
		USING(id_alumno)
	JOIN alumnado.padron_oferta_alumno topfalu
		USING(id_alumno)
	JOIN alumnado.padron_oferta tpoferta
		USING(id_padron_oferta)
	JOIN alumnado.oferta toferta
		USING(id_oferta)
	JOIN alumnado.padron tpadron
		USING(cueanexo)
	JOIN alumnado.localidad tlocalidad
		USING(id_localidad)
	JOIN alumnado.departamento tdepar
		USING(id_departamento)
	WHERE 
		toferta.descripcion LIKE '%Secundaria%' AND
		tpromovidos.pasodegrado = 'S'
	GROUP BY 
		tdepar.nombre, tdepar.id_departamento
	ORDER BY tdepar.nombre) JOIN
(SELECT 
	tdepar.nombre as "Departamento",
	COUNT(id_alumno) as "Promovidos de primaria (2021)"
	FROM alumnado.alumnos_promociones tpromovidos
	JOIN alumnado.alumnos talumnos
		USING(id_alumno)
	JOIN alumnado.padron_oferta_alumno topfalu
		USING(id_alumno)
	JOIN alumnado.padron_oferta tpoferta
		USING(id_padron_oferta)
	JOIN alumnado.oferta toferta
		USING(id_oferta)
	JOIN alumnado.padron tpadron
		USING(cueanexo)
	JOIN alumnado.localidad tlocalidad
		USING(id_localidad)
	JOIN alumnado.departamento tdepar
		USING(id_departamento)
	WHERE 
		toferta.descripcion LIKE '%Primaria%' AND
		tpromovidos.pasodegrado = 'S'
	GROUP BY 
		tdepar.nombre, tdepar.id_departamento
	ORDER BY tdepar.nombre) vconst01 USING("Departamento")