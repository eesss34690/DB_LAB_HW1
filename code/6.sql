SELECT MA.position, C.champion_name
FROM champ C,
(
    SELECT D.position, MAX(D.cnt) AS cnt
    FROM
    (
        SELECT P.position, P.champion_id, COUNT(P.player_id) AS cnt
        FROM match_info M, 
        (
            SELECT position, champion_id, player_id, match_id
            FROM participant
            WHERE position = 'DUO_CARRY' OR position = 'DUO_SUPPORT'OR position = 'JUNGLE'OR position = 'MID'OR position = 'TOP' 
        ) P
        WHERE M.duration BETWEEN 2399 AND 3001 AND M.match_id = P.match_id
        GROUP BY P.position, P.champion_id
    ) D
    GROUP BY D.position
) MA,
(
    SELECT P.position, P.champion_id, COUNT(P.player_id) AS cnt
    FROM match_info M, 
    (
        SELECT position, champion_id, player_id, match_id
        FROM participant
        WHERE position = 'DUO_CARRY' OR position = 'DUO_SUPPORT'OR position = 'JUNGLE'OR position = 'MID'OR position = 'TOP' 
    ) P
    WHERE M.duration BETWEEN 2399 AND 3001 AND M.match_id = P.match_id
    GROUP BY P.position, P.champion_id
)AL
WHERE MA.position = AL.position AND MA.cnt = AL.cnt AND AL.champion_id = C.champion_id
ORDER BY FIELD(MA.position, 'DUO_CARRY', 'DUO_SUPPORT', 'JUNGLE', 'MID', 'TOP')
;