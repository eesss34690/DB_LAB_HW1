SELECT MA.position, C.champion_name, MA.kda
FROM champ C,
(
    SELECT P.position, S.kda, P.champion_id
    FROM 
    (
        SELECT position, champion_id, player_id
        FROM participant
        WHERE position = 'DUO_CARRY' OR position = 'DUO_SUPPORT'OR position = 'JUNGLE'OR position = 'MID'OR position = 'TOP' 
    ) P,
    (
        SELECT player_id, (kills+assists)/deaths AS kda
        FROM stat
        WHERE deaths != 0
    ) S
    WHERE P.player_id = S.player_id
) AL,
(
    SELECT P.position, MAX(S.kda) AS kda
    FROM 
    (
        SELECT position, champion_id, player_id
        FROM participant
        WHERE position = 'DUO_CARRY' OR position = 'DUO_SUPPORT'OR position = 'JUNGLE'OR position = 'MID'OR position = 'TOP' 
    ) P,
    (
        SELECT player_id, (kills+assists)/deaths AS kda
        FROM stat
        WHERE deaths != 0
    ) S
    WHERE P.player_id = S.player_id
    GROUP BY P.position
) MA
WHERE AL.position= MA.position AND AL.kda = MA.kda AND C.champion_id = AL.champion_id
ORDER BY FIELD(MA.position, 'DUO_CARRY', 'DUO_SUPPORT', 'JUNGLE', 'MID', 'TOP')
;
