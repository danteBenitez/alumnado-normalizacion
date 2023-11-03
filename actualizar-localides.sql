UPDATE alumnado.localidad SET id_departamento = s.id_departamento
	FROM (SELECT id_departamento, cod_loca FROM alumnado.padron_csv tpadron_csv
		  JOIN alumnado.departamento tdepar 
		  ON CAST(tdepar.codigo_departamento AS INTEGER) = tpadron_csv.cod_depar
		 ) s WHERE s.cod_loca = alumnado.localidad.codigo_localidad
	