DROP SEQUENCE IF EXISTS serial;


CREATE
TEMPORARY SEQUENCE serial
START 1;


DELETE
FROM alumnado.periodo_materia_alumno;

-- Insertar períodos trimestrales
DO $$
BEGIN
    FOR trimestre IN 1.. 3 LOOP
        INSERT INTO alumnado.periodo_materia_alumno (
            id_periodo_materia_alumno,
            id_padron_oferta_alumno,
            id_materia,
            nro_periodo,
            id_tipo_periodo
        ) SELECT
            id_padron_oferta_alumno,
            id_materia,
            trimestre,
            1
        FROM
            alumnado.notas_csv tnotas_csv
        JOIN
            alumnado.plan tplanes ON tnotas_csv."_id.plan" = tplanes.codigo_plan
        JOIN
            alumnado.alumnos_csv talumnos_csv
                ON talumnos_csv._id = tnotas_csv."_id.dni"
        JOIN
            alumnado.alumnos talumnos
                ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
        JOIN
            alumnado.padron_oferta_alumno tofalum
                ON tofalum.id_alumno = talumnos.id_alumno
                AND tofalum.año = CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER)
                AND tofalum.grado = CAST(tnotas_csv."_id.anio_que_cursa" AS INTEGER)
        JOIN
            alumnado.materias tmaterias
                ON tmaterias.codigo_materia = CONCAT(
                "_id.plan",
                CASE
                    WHEN "_id.anio_que_cursa" IS NOT NULL
                        THEN "_id.anio_que_cursa"
                    ELSE "_id.cuatrimestre_que_cursa"
                END,
                "_id.materia_nro"
            )
        WHERE "_id.cuatrimestre_que_cursa" IS NULL AND
            CONCAT(
                "_id.dni", "_id.anio_lectivo", "_id.plan",
                CASE
                    WHEN "_id.anio_que_cursa" IS NOT NULL
                        THEN "_id.anio_que_cursa"
                    ELSE "_id.cuatrimestre_que_cursa"
                END,
                "_id.materia_nro"
            ) IN (SELECT codigo_nota FROM alumnado.notas_validas);
    END LOOP;
END $$;

do $$
declare
    lastSeq integer;
begin
    SELECT MAX(id_periodo_materia_alumno) + 1 
		INTO lastSeq FROM alumnado.periodo_materia_alumno;
    if lastSeq IS NULL then lastSeq := 1; end if;
    execute 'CREATE SEQUENCE serial INCREMENT BY 1 START WITH ' || lastSeq;
end $$;

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
            "_id.cuatrimestre_que_cursa"::integer,
            2
        FROM
            alumnado.notas_csv tnotas_csv
        JOIN
            alumnado.plan tplanes ON tnotas_csv."_id.plan" = tplanes.codigo_plan
        JOIN
            alumnado.alumnos_csv talumnos_csv
                ON talumnos_csv._id = tnotas_csv."_id.dni"
        JOIN
            alumnado.alumnos talumnos
                ON talumnos.dni = CAST(talumnos_csv._id AS INTEGER)
        JOIN
            alumnado.padron_oferta_alumno tofalum
                ON tofalum.id_alumno = talumnos.id_alumno
                AND tofalum.año = CAST(tnotas_csv."_id.anio_lectivo" AS INTEGER)
                AND tofalum.grado = CAST(tnotas_csv."_id.cuatrimestre_que_cursa" AS INTEGER)
		 JOIN
            alumnado.materias tmaterias
                ON tmaterias.codigo_materia = CONCAT(
                "_id.plan",
                CASE
                    WHEN "_id.anio_que_cursa" IS NOT NULL
                        THEN "_id.anio_que_cursa"
                    ELSE "_id.cuatrimestre_que_cursa"
                END,
                "_id.materia_nro"
            )
        WHERE "_id.cuatrimestre_que_cursa" IS NOT NULL AND
            CONCAT(
                "_id.dni", "_id.anio_lectivo", "_id.plan",
                CASE
                    WHEN "_id.anio_que_cursa" IS NOT NULL
                        THEN "_id.anio_que_cursa"
                    ELSE "_id.cuatrimestre_que_cursa"
                END,
                "_id.materia_nro"
            ) IN (SELECT codigo_nota FROM alumnado.notas_validas)