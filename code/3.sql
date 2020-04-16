SELECT S.champion_name, S.cnt
FROM
(
    SELECT C.champion_name, P.cnt
    FROM champ C,
    (
        SELECT champion_id, COUNT(*) AS cnt
        FROM participant
        WHERE position LIKE '%JUNGLE%'
        GROUP BY champion_id
    ) P
    WHERE P.champion_id = C.champion_id
) S
ORDER BY S.cnt DESC
LIMIT 3;
