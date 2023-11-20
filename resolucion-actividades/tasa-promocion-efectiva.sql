SELECT
	(alumnos_nuevos + promovidos)::float / matricula::float
	as "Tasa de promoción efectiva de secundaria"
FROM (
	
-- Alumnos nuevos
SELECT 1 as id, SUM(
	CASE
		WHEN grado2021 = grado2022 THEN 0
		ELSE 1
	END
) as alumnos_nuevos  FROM (
	SELECT dni, grado as grado2022 FROM alumnado.padron_oferta_alumno tpofalu
		JOIN alumnado.padron_oferta USING(id_padron_oferta)
		JOIN alumnado.oferta toferta USING(id_oferta)
		JOIN alumnado.alumnos talumnos USING(id_alumno)
	WHERE 
		tpofalu.año = 2022 AND
		toferta.oferta_nro = 110 AND
		tpofalu.grado != 1
) JOIN (
	SELECT dni, grado as grado2021 FROM alumnado.padron_oferta_alumno tpofalu
		JOIN alumnado.padron_oferta USING(id_padron_oferta)
		JOIN alumnado.oferta toferta USING(id_oferta)
		JOIN alumnado.alumnos talumnos USING(id_alumno)
	WHERE 
		tpofalu.año = 2021 AND
		toferta.oferta_nro = 110
) v01 USING(dni)

) JOIN (

SELECT 1 as id, SUM(
	CASE 
		WHEN (grado2021 < grado2022) AND oferta2022 > oferta2021 THEN 1
		ELSE 0
	END
) as promovidos FROM (
	SELECT dni, grado as grado2021, oferta_nro as oferta2021 FROM alumnado.padron_oferta_alumno tpofalu
		JOIN alumnado.padron_oferta USING(id_padron_oferta)
		JOIN alumnado.oferta toferta USING(id_oferta)
		JOIN alumnado.alumnos talumnos USING(id_alumno)
	WHERE 
		tpofalu.año = 2021 AND
		toferta.oferta_nro = 110 AND
		(tpofalu.grado = 6 OR tpofalu.grado = 7)
) JOIN (
	SELECT dni, grado as grado2022, oferta_nro as oferta2022 FROM alumnado.padron_oferta_alumno tpofalu
		JOIN alumnado.padron_oferta USING(id_padron_oferta)
		JOIN alumnado.oferta toferta USING(id_oferta)
		JOIN alumnado.alumnos talumnos USING(id_alumno)
	WHERE 
		tpofalu.año = 2022 AND
		(toferta.oferta_nro = 110 OR (tpofalu.grado = 1 AND toferta.oferta_nro = 115))
) v01 USING(dni) ) USING(id) JOIN (

SELECT 1 as id, COUNT(id_alumno) as matricula FROM alumnado.padron_oferta_alumno tpofalu
		JOIN alumnado.padron_oferta USING(id_padron_oferta)
		JOIN alumnado.oferta toferta USING(id_oferta)
		JOIN alumnado.alumnos talumnos USING(id_alumno)
		WHERE 
			toferta.oferta_nro = 110 AND
			tpofalu.año = 2021
) USING(id)

