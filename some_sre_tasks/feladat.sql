SELECT TOP 20 FROM vip_conversion AS VC
  JOIN conversion_type AS CT ON VC.conversion_type_id = CT.id
  WHERE CT.name = 'call-back' AND VC.conversion_time BETWEEN ('2022-03-13', '2022-03-14')