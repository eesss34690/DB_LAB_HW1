SELECT DISTINCT champion_name
FROM champ 
WHERE champion_id NOT IN (
    SELECT T.champion_id
    FROM teamban T, match_info M
    WHERE M.version LIKE '7.7%' AND M.match_id = T.match_id    
)
ORDER BY champion_name;
