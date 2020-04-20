SELECT match_id, CONCAT(FLOOR(duration/3600), ':',FLOOR((duration-3600* FLOOR(duration/3600))/60), ':', duration-3600* FLOOR(duration/3600)-60*FLOOR((duration-3600* FLOOR(duration/3600))/60)) AS time
FROM match_info
ORDER BY duration DESC
LIMIT 5;