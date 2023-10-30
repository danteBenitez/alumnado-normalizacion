INSERT INTO alumnado.barrio(nombre)
	SELECT DISTINCT "domicilio.barrio" FROM alumnado.alumnos_csv;