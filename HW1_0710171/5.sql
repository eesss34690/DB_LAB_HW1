SELECT CASE
    WHEN F.win = 1 then 'win'
    WHEN F.win = 0 then 'lose'
    END
    AS win_lose,
    F.cnt
FROM
(
    SELECT COUNT(A.ma) AS cnt, A.win
    FROM
    (
        SELECT P.match_id AS ma, AVG(S.longesttimespentliving) AS av, S.win
        FROM participant P,
        (
            SELECT player_id, win, longesttimespentliving
            FROM stat 
        ) S
        WHERE P.player_id = S.player_id
        GROUP BY P.match_id, S.win
    ) A
    WHERE A.av > 1200
    GROUP BY A.win
) F;