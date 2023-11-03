ALTER TABLE IF EXISTS alumnado.alumno_plan
    ADD CONSTRAINT alumno_plan_alumno FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_alumno_plan_alumno
    ON alumnado.alumno_plan(id_alumno);

ALTER TABLE IF EXISTS alumnado.alumno_plan
    ADD CONSTRAINT alumno_plan_plan FOREIGN KEY (id_plan)
    REFERENCES alumnado.plan (id_plan) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_alumno_plan_plan
    ON alumnado.alumno_plan(id_plan);

ALTER TABLE IF EXISTS alumnado.direccion_1
    ADD CONSTRAINT direccion1_alumnos FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_direccion1_alumnos
    ON alumnado.direccion_1(id_alumno);

ALTER TABLE IF EXISTS alumnado.direccion_2
    ADD CONSTRAINT direccion2_alumnos FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_direccion2_alumnos
    ON alumnado.direccion_2(id_alumno);

ALTER TABLE IF EXISTS alumnado.direccion_3
    ADD CONSTRAINT direccion3_alumnos FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_direccion3_alumnos
    ON alumnado.direccion_3(id_alumno);

ALTER TABLE IF EXISTS alumnado.direccion_4
    ADD CONSTRAINT direccion4_alumnos FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_direccion4_alumnos
    ON alumnado.direccion_4(id_alumno);

ALTER TABLE IF EXISTS alumnado.oferta_alumno
    ADD CONSTRAINT oferta_alumno_id_alumno FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_oferta_alumno_id_alumno
    ON alumnado.oferta_alumno(id_alumno);

ALTER TABLE IF EXISTS alumnado.padron_oferta_alumno
    ADD CONSTRAINT padron_oferta_alumno_id_alumno FOREIGN KEY (id_alumno)
    REFERENCES alumnado.alumnos (id_alumno) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_padron_oferta_alumno_id_alumno
    ON alumnado.padron_oferta_alumno(id_alumno);

ALTER TABLE IF EXISTS alumnado.localidad
    ADD CONSTRAINT localidad_departamento FOREIGN KEY (id_departamento)
    REFERENCES alumnado.departamento (id_departamento) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION
    NOT VALID;
CREATE INDEX IF NOT EXISTS fki_a
    ON alumnado.localidad(id_departamento);