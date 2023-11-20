CREATE OR REPLACE FUNCTION matricula(
	codigo_oferta integer,
	año integer,
	grado integer
) RETURNS float AS $$
DECLARE 
	vcodigo_oferta ALIAS FOR $1;
	vaño ALIAS FOR $2;
	vgrado ALIAS FOR $3;
BEGIN
	RETURN (SELECT COUNT(DISTINCT id_alumno)
		FROM alumnado.padron_oferta_alumno tpofalu
			JOIN alumnado.padron_oferta tpoferta
				USING(id_padron_oferta)
			JOIN alumnado.oferta toferta
				USING(id_oferta)
			WHERE 
				tpofalu.grado = vgrado AND
				tpofalu.año = vaño AND
				toferta.oferta_nro = vcodigo_oferta);
END; 
$$ LANGUAGE plpgsql