/*SELECT G11.ss2, 
FROM (
SELECT P.ss2 AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio, COUNT(P.ss2) AS cnt
FROM stat S, participant P
WHERE S.player_id = P.player_id AND P.ss1 = 'Flash'
GROUP BY P.ss2
HAVING P.ss2 = 'Ignite' OR P.ss2 = 'Teleport';
)G11,
(
SELECT P.ss1 AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio, COUNT(P.ss2) AS cnt
FROM stat S, participant P
WHERE S.player_id = P.player_id AND P.ss2 = 'Flash'
GROUP BY P.ss1
HAVING P.ss1 = 'Ignite' OR P.ss1 = 'Teleport';
)G22,
(
SELECT (CASE
        WHEN P1.ss2 = 'Flash' THEN P1.ss1
        WHEN P2.ss1 = 'Flash' THEN P2.ss2) AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio,
        (CASE
        WHEN P1.ss2 = 'Flash' THEN COUNT(P1.ss1)
        WHEN P2.ss1 = 'Flash' THEN COUNT(P2.ss2)) AS cnt
FROM stat S, participant P1, participant P2
WHERE S.player_id = P1.player_id AND P1.ss2 = 'Flash' AND S.player_id = P2.player_id AND P2.ss1 = 'Flash'
GROUP BY P1.ss1, P2.ss2
HAVING P1.ss1 = 'Ignite' AND P2.ss2 = 'Teleport';
)G12,
(
SELECT (CASE
        WHEN P1.ss1 = 'Flash' THEN P1.ss2
        WHEN P2.ss2 = 'Flash' THEN P2.ss1) AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio,
        (CASE
        WHEN P1.ss1 = 'Flash' THEN COUNT(P1.ss2)
        WHEN P2.ss2 = 'Flash' THEN COUNT(P2.ss1)) AS cnt
FROM stat S, participant P1, participant P2
WHERE S.player_id = P1.player_id AND P1.ss1 = 'Flash' AND S.player_id = P2.player_id AND P2.ss2 = 'Flash'
GROUP BY P1.ss2, P2.ss1
HAVING P1.ss2 = 'Ignite' AND P2.ss1 = 'Teleport'
)G21,
;*/

SELECT (CASE
            WHEN P.ss1 = 'Flash' THEN P.ss2
            WHEN P.ss2 = 'Flash' THEN P.ss1
            END) AS s,
    SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio, COUNT(*) AS cnt
FROM stat S, participant P
WHERE (P.ss1 = 'Flash' and P.ss2 = 'Ignite') OR (P.ss2 = 'Flash' and P.ss1 = 'Ignite') AND S.player_id = P.player_id
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
WHERE (P.ss1 = 'Flash' and P.ss2 = 'Teleport') OR (P.ss2 = 'Flash' and P.ss1 = 'Teleport') AND S.player_id = P.player_id
GROUP BY (CASE
            WHEN P.ss1 = 'Flash' THEN P.ss2
            WHEN P.ss2 = 'Flash' THEN P.ss1
            END);