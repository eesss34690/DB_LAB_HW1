SELECT SUBSTRING_INDEX(M.version, '.',2) AS `version`
        , SUM(CASE 
                    WHEN S.win = 1 THEN 1
                    WHEN S.win = 0 THEN 0
                    END) AS win_cnt
        , SUM(CASE
                    WHEN S.win = 0 THEN 1
                    WHEN S.win = 1 THEN 0
                    END) AS lose_cnt
        , SUM(CASE 
                    WHEN S.win = 1 THEN 1
                    WHEN S.win = 0 THEN 0
                    END) / COUNT(*) AS win_ratio
FROM match_info M, (
    SELECT player_id, win
    FROM stat
) S,
(
    SELECT L.player_id, L.match_id
    FROM
    (
        SELECT P.player_id, P.match_id, P.player
        FROM
        (
            SELECT champion_id
            FROM champ
            WHERE champion_name = 'Lee Sin'
        ) C, participant P
        WHERE C.champion_id = P.champion_id
    ) L,
    (
        SELECT P.player_id, P.match_id, P.player
        FROM
        (
            SELECT champion_id
            FROM champ
            WHERE champion_name = 'Teemo'
        ) C, participant P
        WHERE C.champion_id = P.champion_id
    ) T
    WHERE L.match_id = T.match_id AND (
        1 = CASE 
                WHEN L.player BETWEEN 1 AND 5 AND T.player BETWEEN 1 AND 5 THEN 1
                WHEN L.player BETWEEN 6 AND 10 AND T.player BETWEEN 6 AND 10 THEN 1
                ELSE 0
            END
    )
) PID
WHERE PID.player_id = S.player_id AND PID.match_id = M.match_id
GROUP BY SUBSTRING_INDEX(M.version, '.',2);
