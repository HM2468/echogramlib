SELECT compositions.echogram_name as gramname ,species.scientific_name as sciname,
       species.english_name as engname, species.species_code as scode,
       compositions.percentage as percent, compositions.mean_length as avglength,
       compositions.n_individuals as num
FROM compositions INNER JOIN species ON compositions.species_code = species.species_code 
ORDER BY compositions.echogram_name