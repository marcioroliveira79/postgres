SELECT
	datum AS data,
	EXTRACT(YEAR FROM datum) AS ano,
	EXTRACT(MONTH FROM datum)::integer AS mes,
	
	to_char(datum, 'TMMonth')::varchar AS mes_nome,
	EXTRACT(DAY FROM datum)::integer AS dia,
	EXTRACT(doy FROM datum)::integer AS dia_ano,
	
	to_char(datum, 'TMDay'::varchar)::varchar AS dia_semana_nome,
	
	
	CASE WHEN EXTRACT(isodow FROM datum) IN (6, 7) THEN 'FinalDeSemana' ELSE 'Semana' END::varchar AS posicao_dia_semana,
	datum +(1 -EXTRACT(DAY FROM datum))::INT AS primeiro_dia_do_mes,
	(DATE_TRUNC('MONTH',datum) +INTERVAL '1 MONTH - 1 day')::DATE AS ultimo_dia_do_mes,
	 datum +(1 -EXTRACT(isodow FROM datum))::INT AS primeiro_dia_da_semana,
	 datum +(7 -EXTRACT(isodow FROM datum))::INT AS ultimo_dia_da_semana,

      CASE  WHEN EXTRACT(MONTH FROM datum)::integer < 7 THEN 'Primeiro' ELSE 'Segundo'   END::varchar AS semestre_ano,
	  
	  CASE  WHEN EXTRACT(MONTH FROM datum)::integer BETWEEN 1 AND 3 THEN 1
	  		WHEN EXTRACT(MONTH FROM datum)::integer  BETWEEN 4 AND 6 THEN 2
			WHEN EXTRACT(MONTH FROM datum)::integer BETWEEN 7 AND 9 THEN 3
	  		ELSE 4   END::varchar AS trismestre_ano,
         
      CASE
         WHEN EXTRACT(quarter FROM datum) = 1 THEN 'Primeiro'
         WHEN EXTRACT(quarter FROM datum) = 2 THEN 'Segundo'
         WHEN EXTRACT(quarter FROM datum) = 3 THEN 'Terceiro'
         WHEN EXTRACT(quarter FROM datum) = 4 THEN 'Quarto'
       END::varchar AS quartil_ano,
        DATE_TRUNC('quarter',datum)::DATE AS primeiro_dia_do_quartil,
       (DATE_TRUNC('quarter',datum) +INTERVAL '3 MONTH - 1 day')::DATE AS ultimo_dia_do_quartil
	
	
FROM (select generate_series(('2001-01-01')::date, now()::date, interval '1 day')::date AS datum) DQ
ORDER BY 1