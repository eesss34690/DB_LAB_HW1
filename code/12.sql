SELECT C.champ_name, KK.position, KK.fast_kill_rate
FROM champ C,
(
    SELECT SUM(S.doublekills* 2+ S.triplekills* 3+ S.quadrakills* 4+ S.pentakills* 5)/ S.kills AS fast_kill_rate, P.position, P.champion_id
    FROM stat S, participant P
    WHERE P.player_id = S.player_id 
    GROUP BY P.position, P.champion_id
    ORDER BY SUM(S.doublekills* 2+ S.triplekills* 3+ S.quadrakills* 4+ S.pentakills* 5)/ S.kills
) KK
WHERE C.champion_id = KK.champion_id;