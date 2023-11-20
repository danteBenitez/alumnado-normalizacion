CREATE OR REPLACE FUNCTION tasa_promocion_efectiva(
	año integer,
	nivel integer
) RETURNS FLOAT AS $$
DECLARE
	vaño ALIAS FOR $1;
	voferta_nro ALIAS FOR $2;
BEGIN
	RETURN (
	SELECT 
		((SUM(alumnos_nuevos) + alumnos_promovidos_ultimo_año) /
		(SUM(matricula))) * 100
	FROM
		(	
			-- Alumnos nuevos del grado g en el año t
			-- = Matricula del grado g en el año t
			--   - Repitentes
			SELECT 
				tpofalu.año, 
				matricula(
					voferta_nro,
					vaño + 1,
					tpofalu.grado
				) - SUM(
					CASE 
						WHEN es_repitente(tpofalu.id_alumno, vaño + 1, voferta_nro) 
							THEN 1
						ELSE 0
					END
				) as alumnos_nuevos
			FROM alumnado.padron_oferta_alumno tpofalu
			WHERE tpofalu.año = vaño
			GROUP BY tpofalu.año, tpofalu.grado
		) JOIN (
			SELECT
				tpofalu.año,
				SUM(
					CASE 
						WHEN
							promociona(tpofalu.id_alumno, vaño, grado, voferta_nro)
						THEN 1
						ELSE 0
					END
				) as alumnos_promovidos_ultimo_año
		 	FROM alumnado.padron_oferta_alumno tpofalu 
			WHERE tpofalu.año = vaño
			GROUP BY tpofalu.año, tpofalu.grado
		) cons01 USING(año) 
		  JOIN (
			 SELECT 
			  	tpofalu.año,
			  	matricula(voferta_nro, vaño, grado)
			  FROM alumnado.padron_oferta_alumno tpofalu
			 WHERE tpofalu.año = vaño
			GROUP BY tpofalu.año, tpofalu.grado
		) cons02 USING(año) GROUP BY alumnos_promovidos_ultimo_año);
END;
$$ LANGUAGE plpgsql;
	
		
SELECT (
	(alumnos_nuevos + promovidos) / (matricula_nivel)  
) FROM 
	(
		SELECT 1 as "id",
			(matricula - repitentes) as alumnos_nuevos FROM (
			SELECT grado, COUNT(id_alumno) as matricula
				FROM alumnado.padron_oferta_alumno tpofalu
				JOIN alumnado.padron_oferta USING(id_padron_oferta)
				JOIN alumnado.oferta toferta USING(id_oferta)
				WHERE 
					tpofalu.año = 2022 AND
					toferta.oferta_nro = 102
				GROUP BY grado
		) JOIN (
			SELECT 1 as "id", SUM(
				CASE	
					WHEN grado2021 = grado2022 THEN
						1
					ELSE 0
				END 
			) as repitentes
				FROM (
					SELECT id_alumno, tpofalu.grado as grado2021
					   FROM alumnado.padron_oferta_alumno tpofalu
						JOIN alumnado.padron_oferta USING(id_padron_oferta)
						JOIN alumnado.oferta toferta USING(id_oferta)
						WHERE 
							tpofalu.año = 2021 AND
							toferta.oferta_nro = 102
						GROUP BY id_alumno, grado
				) JOIN (
					SELECT id_alumno, tpofalu.grado as grado2022
					   FROM alumnado.padron_oferta_alumno tpofalu
						JOIN alumnado.padron_oferta USING(id_padron_oferta)
						JOIN alumnado.oferta toferta USING(id_oferta)
						WHERE 
							tpofalu.año = 2022 AND
							toferta.oferta_nro = 102
						GROUP BY id_alumno, grado
				) v01 USING(id_alumno) GROUP BY id_alumno
		) v02 USING(id)
	) JOIN (
		-- Promovidos
		SELECT 1 as "id",
			SUM(
				CASE	
					WHEN grado2021 != grado2022 THEN
						1
					ELSE 0
				END 
			) as promovidos
				FROM (
					SELECT id_alumno, tpofalu.grado as grado2021
					   FROM alumnado.padron_oferta_alumno tpofalu
						JOIN alumnado.padron_oferta USING(id_padron_oferta)
						JOIN alumnado.oferta toferta USING(id_oferta)
						WHERE 
							tpofalu.año = 2021 AND
							toferta.oferta_nro = 102 AND
							tpofalu.grado = 6
						GROUP BY id_alumno, tpofalu.grado
				) JOIN (
					SELECT id_alumno, tpofalu.grado as grado2022
					   FROM alumnado.padron_oferta_alumno tpofalu
						JOIN alumnado.padron_oferta USING(id_padron_oferta)
						JOIN alumnado.oferta toferta USING(id_oferta)
						WHERE 
							tpofalu.año = 2022 AND
							toferta.oferta_nro = 102 AND
							(tpofalu.grado = 6 OR tpofalu.grado IN (1))
						GROUP BY id_alumno, tpofalu.grado
				) v01 USING(id_alumno) GROUP BY (grado2021)
		) v02 USING(id)
		JOIN (
			SELECT  1 as "id", COUNT(id_alumno)
				FROM alumnado.padron_oferta_alumno tpofalu
						JOIN alumnado.padron_oferta USING(id_padron_oferta)
						JOIN alumnado.oferta toferta USING(id_oferta)
						WHERE 
							tpofalu.año = 2021 AND
							toferta.oferta_nro = 102
		) v03 USING(id)