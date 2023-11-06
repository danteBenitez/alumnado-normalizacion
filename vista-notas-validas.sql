CREATE OR REPLACE VIEW alumnado.notas_validas AS SELECT *,
		CONCAT("_id.dni",
			"_id.anio_lectivo",
			"_id.plan",
			"_id.anio_que_cursa",
			"_id.materia_nro") as codigo_nota
		FROM ALUMNADO.NOTAS_CSV TNOTAS_CSV
		JOIN ALUMNADO.ALUMNOS_CSV TALUMNOS_CSV ON TNOTAS_CSV."_id.dni" = TALUMNOS_CSV._ID
		WHERE (TNOTAS_CSV."_id.anio_que_cursa" = TALUMNOS_CSV.GRADO2021
									AND TNOTAS_CSV."_id.anio_lectivo" = '2021')
			OR (TNOTAS_CSV."_id.anio_que_cursa" = TALUMNOS_CSV.GRADO2022
							AND TNOTAS_CSV."_id.anio_lectivo" = '2022')
			OR ("_id.cuatrimestre_que_cursa" IS NOT NULL);

CREATE OR REPLACE VIEW alumnado.notas_invalidas AS SELECT
	    *,
		CONCAT("_id.dni",
			"_id.anio_lectivo",
			"_id.plan",
			"_id.anio_que_cursa",
			"_id.materia_nro") as codigo_nota
		FROM ALUMNADO.NOTAS_CSV TNOTAS_CSV
		JOIN ALUMNADO.ALUMNOS_CSV TALUMNOS_CSV ON TNOTAS_CSV."_id.dni" = TALUMNOS_CSV._ID
		WHERE (TNOTAS_CSV."_id.anio_que_cursa" != TALUMNOS_CSV.GRADO2021
									OR TNOTAS_CSV."_id.anio_lectivo" != '2021')
			AND (TNOTAS_CSV."_id.anio_que_cursa" != TALUMNOS_CSV.GRADO2022
							OR TNOTAS_CSV."_id.anio_lectivo" != '2022')
			AND ("_id.cuatrimestre_que_cursa" IS NULL);
/*
SELECT CONCAT(
	"_id.dni",
	"_id.anio_lectivo",
	"_id.plan",
	"_id.anio_que_cursa",
	"_id.materia_nro"
) FROM alumnado.notas_csv WHERE CONCAT(
	"_id.dni",
	"_id.anio_lectivo",
	"_id.plan",
	"_id.anio_que_cursa",
	"_id.materia_nro"
) NOT IN (SELECT CONCAT("_id.dni",
	"_id.anio_lectivo",
	"_id.plan",
	"_id.anio_que_cursa",
	"_id.materia_nro") L
	FROM alumnado.notas_validas) AND CONCAT(
	"_id.dni",
	"_id.anio_lectivo",
	"_id.plan",
	"_id.anio_que_cursa",
	"_id.materia_nro"
) NOT IN (
		SELECT codigo_nota FROM alumnado.notas_invalidas
	) ;*/
SELECT * FROM alumnado.notas_validas JOIN
	alumnado.notas_csv tnotas_csv ON
	codigo_nota = CONCAT(
	tnotas_csv."_id.dni",
	tnotas_csv."_id.anio_lectivo",
	tnotas_csv."_id.plan",
	tnotas_csv."_id.anio_que_cursa",
	tnotas_csv."_id.materia_nro"
);