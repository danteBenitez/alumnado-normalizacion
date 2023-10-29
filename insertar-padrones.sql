INSERT INTO alumnado.padron (cueanexo, id_jurisdiccion, id_sector,
	id_ambito, id_departamento, id_localidad,
	nombre, domicilio, id_cod_postal, telefono,
	mail)
	SELECT cueanexo, id_jurisdiccion, id_sector,
	id_ambito, tdepar.id_departamento, id_localidad,
	tpadron.nombre, domicilio, tcod_postal.id_codigo_postal, telefono,
	mail 
	FROM alumnado.padron_csv tpadron
	JOIN alumnado.jurisdiccion tjuris ON tjuris.descripcion = tpadron.juris
	JOIN alumnado.sector tsector ON tpadron.sector = tsector.descripcion
	JOIN alumnado.departamento tdepar ON tdepar.nombre = tpadron.departamento
	JOIN alumnado.localidad tloca ON tloca.nombre = tpadron.localidad AND tloca.codigo_localidad = tpadron.cod_loca
	JOIN alumnado.ambito tambito ON tpadron.ambito = tambito.descripcion
	LEFT JOIN alumnado.codigo_postal tcod_postal ON tcod_postal.codigo = tpadron.cod_postal

	
	