SELECT echograms.echogram_name AS gramname,species.species_code AS fishcode,
       species.scientific_name AS sciname, species.english_name AS englishname,
       compositions.percentage AS percent, compositions.mean_length AS length
FROM echograms INNER JOIN compositions ON echograms.echogram_name = compositions.echogram_name 
INNER JOIN species ON compositions.species_code = species.species_code
ORDER BY species.species_code