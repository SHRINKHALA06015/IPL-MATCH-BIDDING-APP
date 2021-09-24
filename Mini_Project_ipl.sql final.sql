/*1.	Show the percentage of wins of each bidder in the order of highest to lowest percentage.*/
use ipl;
select BID_STATUS  from IPL_BIDDING_DETAILS;
select * from ipl_bidding_details
select * from ipl_bidder_points
select * from ipl_bidder_details


SELECT IPL_BIDDING_DETAILS.BIDDER_ID, COUNT(IPL_BIDDING_DETAILS.BID_STATUS) , NO_OF_BIDS,
(COUNT(IPL_BIDDING_DETAILS.BID_STATUS)/NO_OF_BIDS)*100 AS PERCENTAGE_WIN
FROM IPL_BIDDING_DETAILS
INNER JOIN IPL_BIDDER_POINTS
ON IPL_BIDDING_DETAILS.BIDDER_ID = IPL_BIDDER_POINTS.BIDDER_ID
AND IPL_BIDDING_DETAILS.BID_STATUS = "Won"
GROUP BY IPL_BIDDING_DETAILS.BIDDER_ID, NO_OF_BIDS
ORDER BY PERCENTAGE_WIN DESC;

#2.	Display the number of matches conducted at each stadium with stadium name, city from the database.
SELECT IPL_STADIUM.STADIUM_ID, STADIUM_NAME,CITY , COUNT(IPL_STADIUM.STADIUM_ID) AS TOTAL_MATCHES
FROM IPL_STADIUM
INNER JOIN IPL_MATCH_SCHEDULE
ON IPL_STADIUM.STADIUM_ID = IPL_MATCH_SCHEDULE.STADIUM_ID
GROUP BY IPL_STADIUM.STADIUM_ID,STADIUM_NAME
ORDER BY TOTAL_MATCHES;
select * from ipl_stadium
select * from ipl_match_schedule
select * from ipl_match

#3.	In a given stadium, what is the percentage of wins by a team which has won the toss?
select IPL_STADIUM.STADIUM_ID,STADIUM_NAME,CITY,
(SELECT COUNT(*) FROM IPL_MATCH JOIN IPL_MATCH_SCHEDULE ON IPL_MATCH_SCHEDULE.MATCH_ID=IPL_MATCH.MATCH_ID 
WHERE TOSS_WINNER=MATCH_WINNER and IPL_MATCH_SCHEDULE.STADIUM_ID=IPL_STADIUM.STADIUM_ID)/
(SELECT COUNT(*) from ipl_match_schedule where IPL_MATCH_SCHEDULE.stadium_id = IPL_STADIUM.stadium_id)*100 AS WIN_PERCENTAGE
from IPL_STADIUM; 

4)	Show the total bids along with bid team and team name.

SELECT COUNT(BID_TEAM) ,BID_TEAM,IPL_TEAM.TEAM_NAME
FROM IPL_BIDDING_DETAILS
INNER JOIN IPL_TEAM
ON IPL_BIDDING_DETAILS.BID_TEAM = IPL_TEAM.TEAM_ID
GROUP BY BID_TEAM;
use ipl;
#5.	Show the team id who won the match as per the win details

SELECT TEAM_ID, TEAM_NAME, TEAM_ID1, TEAM_ID2, MATCH_WINNER,IPL_MATCH.WIN_DETAILS
FROM IPL_TEAM
inner JOIN IPL_MATCH
ON SUBSTR(IPL_TEAM.REMARKS,1,3) = SUBSTR(IPL_MATCH.WIN_DETAILS,6,3); 

Select case when match_winner=1 then team_id1 when match_winner2 then team_id 2 from ipl_match
select distinct match_winner from ipl_match

select a.team_id,b.team_name,a.win_details from 
(Select case when match_winner='1' then team_id1 when match_winner='2' then team_id2 end as team_id,win_details from ipl_match) a
left join (select team_id,team_name from ipl_team) b on a.team_id = b.team_id;




#.6	Display total matches played, total matches won and total matches lost by team along with its team name.

SELECT IPL_TEAM_STANDINGS.TEAM_ID,IPL_TEAM.TEAM_NAME,
SUM(IPL_TEAM_STANDINGS.MATCHES_PLAYED) AS TOTAL_MATCH_PLAYED,
SUM(IPL_TEAM_STANDINGS.MATCHES_WON) AS WON_MATCHES,
SUM(IPL_TEAM_STANDINGS.MATCHES_LOST) AS LOST_MATCHES
FROM IPL_TEAM_STANDINGS
INNER JOIN IPL_TEAM
ON IPL_TEAM_STANDINGS.TEAM_ID=IPL_TEAM.TEAM_ID
GROUP BY IPL_TEAM_STANDINGS.TEAM_ID;

#7.	Display the bowlers for Mumbai Indians team.

SELECT IPL_TEAM_PLAYERS.PLAYER_ID,IPL_TEAM.TEAM_NAME,IPL_TEAM_PLAYERS.REMARKS,PLAYER_ROLE, PLAYER_NAME
FROM IPL_PLAYER
INNER JOIN IPL_TEAM_PLAYERS
ON IPL_TEAM_PLAYERS.PLAYER_ID = IPL_PLAYER.PLAYER_ID
AND PLAYER_ROLE LIKE "%Bowler%"
INNER JOIN IPL_TEAM
ON IPL_TEAM.TEAM_ID = IPL_TEAM_PLAYERS.TEAM_ID
AND TEAM_NAME LIKE "%Mumbai%"
ORDER BY PLAYER_ID;

/*8.	How many all-rounders are there in each team, Display the teams with more than 4 
all-rounder in descending order.*/

SELECT TEAM_NAME, PLAYER_ROLE, COUNT(PLAYER_ROLE) AS TOTAL
FROM IPL_TEAM
INNER JOIN IPL_TEAM_PLAYERS
ON SUBSTR(IPL_TEAM.REMARKS,-2) = SUBSTR(IPL_TEAM_PLAYERS.REMARKS,-2)
GROUP BY PLAYER_ROLE, TEAM_NAME
HAVING PLAYER_ROLE LIKE "All-Rounder" AND COUNT(PLAYER_ROLE) > 4
ORDER BY COUNT(PLAYER_ROLE) DESC;

