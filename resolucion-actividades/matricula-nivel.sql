CREATE OR REPLACE FUNCTION matriculas_nivel(
	oferta_nro integer,
	año integer
) RETURNS integer AS $$
DECLARE 
	voferta ALIAS FOR $1;
	vaño ALIAS FOR $2;
BEGIN
	RETURN (
		SELECT SUM(
			matricula(
				voferta,
				vaño,
				grado
			)
		) FROM (SELECT tpofalu.grado FROM alumnado.padron_oferta_alumno tpofalu
			JOIN alumnado.padron_oferta tpoferta
				USING(id_padron_oferta)
			JOIN alumnado.oferta toferta
				USING(id_oferta)
			WHERE 
				tpofalu.año = vaño AND
				toferta.oferta_nro = voferta
			GROUP BY tpofalu.grado)
	);
END;
$$ LANGUAGE plpgsql;