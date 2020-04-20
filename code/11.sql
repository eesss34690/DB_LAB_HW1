(
SELECT P.ss2,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio
FROM stat S, participant P
WHERE S.player_id = P.player_id AND P.ss1 = 'Flash'
GROUP BY P.ss2
HAVING P.ss2 = 'Ignite' OR P.ss2 = 'Teleport'
)G11,
(
SELECT P.ss1,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio
FROM stat S, participant P
WHERE S.player_id = P.player_id AND P.ss2 = 'Flash'
GROUP BY P.ss1
HAVING P.ss1 = 'Ignite' OR P.ss1 = 'Teleport'
)G22,
;
