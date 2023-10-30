-- Función que obtienen el ID de barrio a partir del nombre del mismo
DROP FUNCTION IF EXISTS obtener_barrio_id(varchar);
CREATE FUNCTION obtener_barrio_id(varchar) RETURNS TABLE(id_barrio integer) AS $$
DECLARE
   barrio ALIAS FOR $1;
BEGIN
    RETURN QUERY SELECT b.id_barrio FROM alumnado.barrio AS b WHERE barrio = b.nombre;
END;
$$ LANGUAGE plpgsql;

-- Crea alumnos a partir de una tabla extraída directamente de los datos CSV correspondientes
INSERT INTO alumnado.alumnos(
	dni, apellido, nombre, id_sexo, fecha_nacimiento, id_nacionalidad, id_barrio, id_tipo_barrio)
	SELECT CAST(_id AS INTEGER) as dni, apellido, nombre, id_sexo, CAST(fecha_nacim as DATE), id_nacionalidad,
	obtener_barrio_id("domicilio.barrio"),
	CASE true 
		WHEN "domicilio.calle" IS NOT NULL AND "domicilio.numero" IS NOT NULL THEN 1
		WHEN "domicilio.manzana" IS NOT NULL AND "domicilio.casa" IS NOT NULL
			 AND "domicilio.sector" IS NULL THEN 2
		WHEN "domicilio.sector" IS NOT NULL AND "domicilio.manzana" IS NOT NULL
			 AND "domicilio.casa" IS NOT NULL THEN 3
		WHEN "domicilio.torre" IS NOT NULL AND "domicilio.departamento" IS NOT NULL
			THEN 4
		ELSE NULL
	END
	FROM alumnado.alumnos_csv 
	JOIN alumnado.sexo ON sexo.descripcion LIKE CONCAT(alumnos_csv.sexo, '%')
	JOIN alumnado.nacionalidad ON nacionalidad.descripcion = alumnos_csv.nacionalidad;