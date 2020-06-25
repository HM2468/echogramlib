SELECT my_queries.gramname,species.species_code AS fishcode,
    species.scientific_name AS sciname, species.english_name AS englishname,
    compositions.percentage AS percent, compositions.mean_length AS length,
    my_queries.date,my_queries.time,my_queries.lat,my_queries.long,
    my_queries.freq,my_queries.userid,my_queries.username,my_queries.speed
FROM my_queries INNER JOIN compositions ON my_queries.gramname = compositions.echogram_name 
INNER JOIN species ON compositions.species_code = species.species_code
ORDER BY species.species_code