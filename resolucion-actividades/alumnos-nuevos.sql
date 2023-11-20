CREATE OR REPLACE FUNCTION alumnos_nuevos(
	oferta_nro integer,
	año integer
) RETURNS integer AS $$
DECLARE 
	voferta ALIAS FOR $1;
	vaño ALIAS FOR $2;
BEGIN

	RETURN (SELECT matricula - repitentes FROM (
	SELECT 1 as "id", SUM(matricula(voferta, vaño, grado)) as matricula FROM
		(SELECT DISTINCT grado FROM alumnado.padron_oferta_alumno
			JOIN alumnado.padron_oferta tpoferta
				USING(id_padron_oferta)
			JOIN alumnado.oferta toferta
				USING(id_oferta)
			WHERE toferta.oferta_nro = voferta
		)
	) JOIN (
		SELECT 1 as "id", SUM(
			CASE
				WHEN es_repitente(id_alumno, vaño, voferta)
					THEN 1
				ELSE 0
			END) as repitentes
		FROM alumnado.padron_oferta_alumno  tpofalu
			JOIN alumnado.padron_oferta tpoferta
				USING(id_padron_oferta)
			JOIN alumnado.oferta toferta
				USING(id_oferta)
		WHERE toferta.oferta_nro = voferta AND
			  tpofalu.año = vaño
	) cons01 USING(id));
END;
$$ LANGUAGE plpgsql;