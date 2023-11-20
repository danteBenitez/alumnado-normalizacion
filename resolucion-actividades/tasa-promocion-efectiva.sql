CREATE OR REPLACE FUNCTION tasa_promocion_efectiva(
	año integer,
	nivel integer,
	ultimo_año integer
) RETURNS FLOAT AS $$
DECLARE
	vaño ALIAS FOR $1;
	voferta_nro ALIAS FOR $2;
	vultimo ALIAS FOR $3;
BEGIN
	RETURN (
		SELECT 
			(alumnos_nuevos(voferta_nro, vaño+1) +
			promovidos(vaño, vultimo, voferta_nro))::float
		/ ( matriculas_nivel( voferta_nro, vaño ) )::float
				
			
	);
END
$$ LANGUAGE plpgsql;
	
		
	