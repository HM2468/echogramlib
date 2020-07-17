SELECT echograms.echogram_name AS gramname,echograms.latitude AS lat,
       echograms.longitude AS long,hauls.fish_date AS date,
       echograms.frequency AS frequency, echograms.image_filename AS image
FROM echograms INNER JOIN hauls ON echograms.haul_id = hauls.id
ORDER BY echograms.echogram_name