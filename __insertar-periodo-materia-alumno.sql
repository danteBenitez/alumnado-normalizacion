DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

DELETE FROM alumnado.periodo_materia_alumno;

INSERT INTO alumnado.periodo_materia_alumno (
    id_periodo_materia_alumno,
    id_padron_oferta_alumno,
    id_materia,
    nro_periodo,
    id_tipo_periodo
) SELECT 
    nextval('serial'),
	 id_padron_oferta_alumno,
    id_materia,
    1,
    1
 FROM alumnado.notas_validas tnotas_validas
 JOIN alumnado.alumnos talumno
    ON talumno.dni = CAST(tnotas_validas."_id.dni" AS INTEGER)
 JOIN alumnado.alumnos_csv talumnos_csv
 	ON talumnos_csv._id = tnotas_validas."_id.dni"
 JOIN alumnado.materias tmateria
    ON CONCAT(
        tnotas_validas."_id.plan",
        tnotas_validas."_id.anio_que_cursa",
        tnotas_validas."_id.materia_nro"
    ) = tmateria.codigo_materia
 JOIN alumnado.padron_oferta_alumno tpofalum
    ON tpofalum.id_alumno = talumno.id_alumno
 WHERE tnotas_validas."_id.cuatrimestre_que_cursa" IS NULL
 GROUP BY CONCAT(
		"_id.dni",
		"_id.anio_lectivo",
		"_id.plan",
		"_id.anio_que_cursa",
		"_id.materia_nro"
	), id_padron_oferta_alumno, id_materia;

INSERT INTO alumnado.periodo_materia_alumno (
    id_periodo_materia_alumno,
    id_padron_oferta_alumno,
    id_materia,
    nro_periodo,
    id_tipo_periodo
) SELECT 
    nextval('serial'),
	 id_padron_oferta_alumno,
    id_materia,
    2,
    1
 FROM alumnado.notas_validas tnotas_validas
 JOIN alumnado.alumnos talumno
    ON talumno.dni = CAST(tnotas_validas."_id.dni" AS INTEGER)
 JOIN alumnado.alumnos_csv talumnos_csv
 	ON talumnos_csv._id = tnotas_validas."_id.dni"
 JOIN alumnado.materias tmateria
    ON CONCAT(
        tnotas_validas."_id.plan",
        tnotas_validas."_id.anio_que_cursa",
        tnotas_validas."_id.materia_nro"
    ) = tmateria.codigo_materia
 JOIN alumnado.padron_oferta_alumno tpofalum
    ON tpofalum.id_alumno = talumno.id_alumno
 WHERE tnotas_validas."_id.cuatrimestre_que_cursa" IS NULL
 GROUP BY CONCAT(
		"_id.dni",
		"_id.anio_lectivo",
		"_id.plan",
		"_id.anio_que_cursa",
		"_id.materia_nro"
	), id_padron_oferta_alumno, id_materia;

INSERT INTO alumnado.periodo_materia_alumno (
    id_periodo_materia_alumno,
    id_padron_oferta_alumno,
    id_materia,
    nro_periodo,
    id_tipo_periodo
) SELECT 
    nextval('serial'),
	 id_padron_oferta_alumno,
    id_materia,
    3,
    1
 FROM alumnado.notas_validas tnotas_validas
 JOIN alumnado.alumnos talumno
    ON talumno.dni = CAST(tnotas_validas."_id.dni" AS INTEGER)
 JOIN alumnado.alumnos_csv talumnos_csv
 	ON talumnos_csv._id = tnotas_validas."_id.dni"
 JOIN alumnado.materias tmateria
    ON CONCAT(
        tnotas_validas."_id.plan",
        tnotas_validas."_id.anio_que_cursa",
        tnotas_validas."_id.materia_nro"
    ) = tmateria.codigo_materia
 JOIN alumnado.padron_oferta_alumno tpofalum
    ON tpofalum.id_alumno = talumno.id_alumno
 WHERE tnotas_validas."_id.cuatrimestre_que_cursa" IS NULL
 GROUP BY CONCAT(
		"_id.dni",
		"_id.anio_lectivo",
		"_id.plan",
		"_id.anio_que_cursa",
		"_id.materia_nro"
	), id_padron_oferta_alumno, id_materia;

INSERT INTO alumnado.periodo_materia_alumno (
    id_periodo_materia_alumno,
    id_padron_oferta_alumno,
    id_materia,
    nro_periodo,
    id_tipo_periodo
) SELECT 
    nextval('serial'),
	 id_padron_oferta_alumno,
    id_materia,
    "_id.cuatrimestre_que_cursa",
    2
 FROM alumnado.notas_validas tnotas_validas
 JOIN alumnado.alumnos talumno
    ON talumno.dni = CAST(tnotas_validas."_id.dni" AS INTEGER)
 JOIN alumnado.alumnos_csv talumnos_csv
 	ON talumnos_csv._id = tnotas_validas."_id.dni"
 JOIN alumnado.materias tmateria
    ON CONCAT(
        tnotas_validas."_id.plan",
        tnotas_validas."_id.cuatrimestre_que_cursa",
        tnotas_validas."_id.materia_nro"
    ) = tmateria.codigo_materia
 JOIN alumnado.padron_oferta_alumno tpofalum
    ON tpofalum.id_alumno = talumno.id_alumno
 WHERE tnotas_validas."_id.cuatrimestre_que_cursa" IS NOT NULL
 GROUP BY CONCAT(
		"_id.dni",
		"_id.anio_lectivo",
		"_id.plan",
		"_id.cuatrimestre_que_cursa",
		"_id.materia_nro"
	), "_id.cuatrimestre_que_cursa", id_padron_oferta_alumno, id_materia;

 

-- Modificación en progreso
DROP SEQUENCE IF EXISTS serial;
CREATE TEMPORARY SEQUENCE serial START 1;

SELECT
    *
 FROM alumnado.notas_csv tnotas_csv 
 JOIN alumnado.alumnos talumno
    ON talumno.dni = CAST(tnotas_csv."_id.dni" AS INTEGER)
 JOIN alumnado.alumnos_csv talumnos_csv
 	ON talumno.dni = CAST(talumnos_csv._id AS INTEGER)
 JOIN alumnado.materias tmateria
    ON CONCAT(
        tnotas_csv."_id.plan",
        tnotas_csv."_id.anio_que_cursa",
        tnotas_csv."_id.materia_nro"
    ) = tmateria.codigo_materia
 JOIN alumnado.plan tplan
 	ON tnotas_csv."_id.plan" =  CAST(tplan.codigo_plan AS character varying)
 JOIN alumnado.padron_oferta_alumno tpofalum
    ON tpofalum.id_alumno = talumno.id_alumno AND
	   CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER) = tpofalum.año
 JOIN alumnado.padron_oferta tpoferta
 	USING(id_padron_oferta)
 WHERE 
 	"_id.cuatrimestre_que_cursa" IS NULL AND
	(
	 (tnotas_csv."_id.plan" = talumnos_csv."plan2021" AND
	 tnotas_csv."_id.anio_lectivo" = '2021') OR
	 (tnotas_csv."_id.plan" = talumnos_csv."plan2022" AND
	  tnotas_csv."_id.anio_lectivo" = '2022'
	 )
	)
UNION
SELECT
    *
 FROM alumnado.notas_csv tnotas_csv 
 JOIN alumnado.alumnos talumno
    ON talumno.dni = CAST(tnotas_csv."_id.dni" AS INTEGER)
 JOIN alumnado.alumnos_csv talumnos_csv
 	ON talumno.dni = CAST(talumnos_csv._id AS INTEGER)
 JOIN alumnado.materias tmateria
    ON CONCAT(
        tnotas_csv."_id.plan",
        tnotas_csv."_id.cuatrimestre_que_cursa",
        tnotas_csv."_id.materia_nro"
    ) = tmateria.codigo_materia
 JOIN alumnado.plan tplan
 	ON tnotas_csv."_id.plan" =  CAST(tplan.codigo_plan AS character varying)
 JOIN alumnado.padron_oferta_alumno tpofalum
    ON tpofalum.id_alumno = talumno.id_alumno AND
	   CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER) = tpofalum.año
 JOIN alumnado.padron_oferta tpoferta
 	USING(id_padron_oferta)
 WHERE 
	(
	 (tnotas_csv."_id.plan" = talumnos_csv."plan2021" AND
	 tnotas_csv."_id.anio_lectivo" = '2021') OR
	 (tnotas_csv."_id.plan" = talumnos_csv."plan2022" AND
	  tnotas_csv."_id.anio_lectivo" = '2022'
	 )
	);
