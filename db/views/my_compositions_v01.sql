SELECT echograms.echogram_name as gramname ,species.scientific_name as sciname,
       species.english_name as engname, species.species_code as scode,
       compositions.percentage as percent, compositions.mean_length as avglength
FROM echograms INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name
INNER JOIN species ON compositions.species_code = species.species_code 
ORDER BY echograms.echogram_name