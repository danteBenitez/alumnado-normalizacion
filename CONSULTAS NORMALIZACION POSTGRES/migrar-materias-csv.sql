INSERT INTO alumnado.materias(nombre, id_plan, codigo_materia)
	SELECT espacio, id_plan, _id FROM alumnado.materias_csv
	JOIN alumnado.plan ON codigo_plan = materias_csv.plan_id
	