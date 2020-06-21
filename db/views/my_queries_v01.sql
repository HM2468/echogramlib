SELECT echograms.echogram_name,echograms.record_date,users.name
FROM Echograms INNER JOIN Users ON Echograms.user_id = Users.id
ORDER BY users.name

