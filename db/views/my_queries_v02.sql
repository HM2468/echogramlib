SELECT echograms.echogram_name AS gramname,echograms.record_date AS date,
       echograms.record_time AS time, echograms.latitude AS lat,
       echograms.longitude AS long, echograms.frequency AS freq,
       echograms.user_id AS userid, users.name AS username,
       hauls.fish_speed AS speed
FROM users INNER JOIN echograms ON echograms.user_id = users.id 
INNER JOIN hauls ON echograms.echogram_name = hauls.echogram_name
ORDER BY users.name