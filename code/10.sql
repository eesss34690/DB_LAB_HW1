SELECT PL.champion_name, SUM(CASE 
                    WHEN S1.win = 1 THEN 1
                    WHEN S1.win = 0 THEN 0
                    END) / COUNT(S1.win) AS win_ratio, AVG((S1.kills + S1.assists) / S1.deaths) AS self_kda,
                    AVG(S1.goldearned) AS self_avg_gold, PL.enemy_champ_name, AVG((S2.kills + S2.assists) / S2.deaths) AS enemy_kda,
                    AVG(S2.goldearned) AS enemy_avg_gold, COUNT(*) AS battle_record
FROM stat S1, stat S2, (
    SELECT P.champion_id, P.player_id, C.champion_name, R.enemy_id, R.enemy_champ_name
    FROM participant P, champ C,
    (    
        SELECT P.player, P.match_id, P.player_id AS enemy_id, C.enemy_champ_name
        FROM
        (
            SELECT champion_id, champion_name AS enemy_champ_name
            FROM champ
            WHERE champion_name = 'Renekton'
        ) C, participant P
        WHERE C.champion_id = P.champion_id AND P.position = 'TOP'
    ) R
    WHERE P.match_id = R.match_id AND C.champion_id = P.champion_id AND (
        1 = CASE 
                WHEN P.player BETWEEN 1 AND 5 AND R.player BETWEEN 6 AND 10 THEN 1
                WHEN P.player BETWEEN 6 AND 10 AND R.player BETWEEN 1 AND 5 THEN 1
                ELSE 0
            END
    )
) PL
WHERE S1.player_id = PL.player_id AND S2.player_id = PL.enemy_id
GROUP BY PL.champion_name, PL.enemy_champ_name
HAVING COUNT(*) > 100
ORDER BY SUM(CASE 
                    WHEN S1.win = 1 THEN 1
                    WHEN S1.win = 0 THEN 0
                    END) / COUNT(S1.win) DESC 
LIMIT 5;
