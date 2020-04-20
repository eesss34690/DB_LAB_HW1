SELECT (CASE
            WHEN P.ss1 = 'Flash' THEN P.ss2
            WHEN P.ss2 = 'Flash' THEN P.ss1
            END) AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio, COUNT(*) AS cnt
FROM stat S, participant P
WHERE ((P.ss1 = 'Flash' and P.ss2 = 'Ignite') OR (P.ss2 = 'Flash' and P.ss1 = 'Ignite')) AND S.player_id = P.player_id
GROUP BY (CASE
            WHEN P.ss1 = 'Flash' THEN P.ss2
            WHEN P.ss2 = 'Flash' THEN P.ss1
            END);

SELECT (CASE
            WHEN P.ss1 = 'Flash' THEN P.ss2
            WHEN P.ss2 = 'Flash' THEN P.ss1
            END) AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio, COUNT(*) AS cnt
FROM stat S, participant P
WHERE ((P.ss1 = 'Flash' and P.ss2 = 'Teleport') OR (P.ss2 = 'Flash' and P.ss1 = 'Teleport')) AND S.player_id = P.player_id
GROUP BY (CASE
            WHEN P.ss1 = 'Flash' THEN P.ss2
            WHEN P.ss2 = 'Flash' THEN P.ss1
            END);
