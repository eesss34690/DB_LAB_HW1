
CREATE TABLE champ(
     champion_name VARCHAR(15) NOT NULL,
     champion_id int NOT NULL,
     PRIMARY KEY (champion_id)
);
CREATE TABLE match_info(
     match_id int NOT NULL,
     duration int,
     version varchar(15),
     PRIMARY KEY (match_id)
);
CREATE TABLE participant(
     player_id int NOT NULL,
     match_id int NOT NULL,
     player tinyint,
     champion_id int NOT NULL,
     ss1 varchar(15),
     ss2 varchar(15),
     position varchar(13) NOT NULL,
     PRIMARY KEY (player_id),
     FOREIGN KEY (match_id) REFERENCES match_info (match_id)
);
CREATE TABLE teamban (
     match_id int NOT NULL,
     team char(1) NOT NULL,
     champion_id int NOT NULL,
     banturn tinyint NOT NULL,
     PRIMARY KEY (match_id, banturn)

);
CREATE TABLE stat (
     player_id int NOT NULL,
     win boolean,
     item1 smallint,
     item2 smallint,
     item3 smallint,
     item4 smallint,
     item5 smallint,
     item6 smallint,
     kills tinyint,
     deaths tinyint,
     assists tinyint,
     longesttimespentliving smallint,
     doublekills tinyint,
     triplekills tinyint,
     quadrakills tinyint,
     pentakills tinyint,
     legendarykills tinyint,
     goldearned mediumint,
     firstblood boolean,
     PRIMARY KEY (player_id)
);

load data local infile './champs.csv'
into table champ
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile './matches.csv'
into table match_info
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;


load data local infile './participants.csv'
into table participant
fields terminated by ','
lines terminated by '\r\n'
ignore 1 lines;

load data local infile './teambans.csv'
into table teamban
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile './stats.csv'
into table stat
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
