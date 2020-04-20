select P.player_id, C.champion_name, SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) AS win_ratio
from champ C, participant P,stat S
where P.player_id = S.player_id and P.champion_id = C.champion_id
group by P.player_id
having SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win) = max(SUM(CASE 
        WHEN S.win = 1 THEN 1
        WHEN S.win = 0 THEN 0
        END) / COUNT(S.win));