SELECT
  System.Timestamp() AS windowEnd,
  location,
  COUNT(*) AS readingCount,
  AVG(CAST(iceThickness AS float)) AS avgIceThickness,
  MIN(CAST(iceThickness AS float)) AS minIceThickness,
  MAX(CAST(iceThickness AS float)) AS maxIceThickness,
  AVG(CAST(surfaceTemperature AS float)) AS avgSurfaceTemperature,
  MIN(CAST(surfaceTemperature AS float)) AS minSurfaceTemperature,
  MAX(CAST(surfaceTemperature AS float)) AS maxSurfaceTemperature,
  MAX(CAST(snowAccumulation AS float)) AS maxSnowAccumulation,
  AVG(CAST(externalTemperature AS float)) AS avgExternalTemperature,
  CASE
    WHEN AVG(CAST(iceThickness AS float)) >= 30 AND AVG(CAST(surfaceTemperature AS float)) <= -2 THEN 'Safe'
    WHEN AVG(CAST(iceThickness AS float)) >= 25 AND AVG(CAST(surfaceTemperature AS float)) <= 0 THEN 'Caution'
    ELSE 'Unsafe'
  END AS safetyStatus
INTO
  cosmosOutput
FROM
  iothubInput TIMESTAMP BY timestamp
GROUP BY
  TumblingWindow(minute, 5),
  location;
