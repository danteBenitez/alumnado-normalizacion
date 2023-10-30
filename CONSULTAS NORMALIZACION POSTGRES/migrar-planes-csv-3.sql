INSERT INTO alumnado.plan(descripcion, fecha_plan, codigo_plan)
	SELECT carrera, fplan, _id as codigo_plan FROM alumnado.planes_csv