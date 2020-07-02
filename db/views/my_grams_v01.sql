SELECT echograms.echogram_name AS gramname,echograms.latitude AS lat,
       echograms.longitude AS long,hauls.fish_date AS date
FROM echograms INNER JOIN hauls ON echograms.echogram_name = hauls.echogram_name 
ORDER BY echograms.echogram_name