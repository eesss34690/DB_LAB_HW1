SELECT COUNT(S.A) AS cnt
FROM(
    SELECT DISTINCT SUBSTRING_INDEX(version, '.',2) AS A
    FROM match_info
) S;

