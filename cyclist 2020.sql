SELECT * FROM cyclist_2025.divvy_trips_2019_q1;

---data cleaning
1. Remove duplicates
2. Standardize the data(spelling etc)
3. Check for Null and blank Values
4. Remove columns or rows that are unnecessary

CREATE TABLE cycling_table
LIKE divvy_trips_2019_q1;

CREATE TABLE cycling_table1
LIKE divvy_trips_2020_q1;

SELECT *
FROM cycling_table;

INSERT INTO cycling_table
SELECT *
FROM divvy_trips_2019_q1;

INSERT INTO cycling_table1
SELECT *
FROM divvy_trips_2020_q1;

SELECT *
FROM cycling_table1;



CREATE TABLE `current_table` (
  `trip_id` int DEFAULT NULL,
  `start_time` text,
  `end_time` text,
  `usertype` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM current_table;

INSERT INTO current_table
SELECT cycling_table.trip_id,cycling_table.start_time,cycling_table.end_time,cycling_table.usertype
FROM cycling_table
JOIN cycling_table1 ON cycling_table.trip_id=cycling_table1.ride_id;



--CHECKING FOR DUPLICATES

SELECT *,ROW_NUMBER() OVER(PARTITION BY trip_id) AS row_num
FROM cycling_table;


WITH duplicate_cte AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY trip_id) AS row_num
FROM cycling_table
)
SELECT *
FROM duplicate_cte
WHERE row_num>1;

---No Duplicates for cycling_table

SELECT *,ROW_NUMBER() OVER(PARTITION BY ride_id) AS row_num
FROM cycling_table1;

WITH duplicate_cte1 AS (SELECT *,ROW_NUMBER() OVER(PARTITION BY ride_id) AS row_num
FROM cycling_table1
)
SELECT *
FROM duplicate_cte1
WHERE row_num>1;

---No duplicates

CREATE TABLE `cycling_table1.1` (
  `trip_id` int DEFAULT NULL,
  `start_time` text,
  `end_time` text,
  `bikeid` int DEFAULT NULL,
  `from_station_id` int DEFAULT NULL,
  `from_station_name` text,
  `to_station_id` int DEFAULT NULL,
  `to_station_name` text,
  `usertype` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM `cycling_table1.1`;

INSERT INTO `cycling_table1.1`
SELECT trip_id,start_time,end_time,bikeid,from_station_id,from_station_name,to_station_id,to_station_name,usertype
FROM cycling_table;

CREATE TABLE `cycling_table1.2` (
  `trip_id` text,
  `start_time` text,
  `end_time` text,
  `bikeid` text,
  `from_station_id` int DEFAULT NULL,
  `from_station_name` text,
  `to_station_id` int DEFAULT NULL,
  `to_station_name` text,
  `usertype` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
FROM `cycling_table1.2`;

INSERT INTO `cycling_table1.2`
SELECT ride_id,started_at,ended_at,rideable_type,start_station_id,start_station_name,end_station_id,end_station_name,member_casual
FROM cycling_table1;

--Standard data

SELECT *
FROM `cycling_table1.2`
WHERE usertype IS NULL;

ALTER TABLE `cycling_table1.2`
ALTER COLUMN start_time yy%;






SELECT * FROM `cycling_table1.1`
UNION
SELECT * FROM `cycling_table1.2`;



CREATE TABLE `Cycling dataset` (
  `trip_id` text,
  `start_time` text,
  `end_time` text,
  `bikeid` text,
  `from_station_id` int DEFAULT NULL,
  `from_station_name` text,
  `to_station_id` int DEFAULT NULL,
  `to_station_name` text,
  `usertype` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM `cycling dataset`

INSERT INTO `cycling dataset`
SELECT  *
FROM (SELECT * FROM `cycling_table1.1`
 UNION
SELECT * FROM `cycling_table1.2`) AS Union_table;













CREATE TABLE `cycling_table2` (
  `trip_id` int DEFAULT NULL,
  `start_time` text,
  `end_time` text,
  `usertype` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM cycling_table2;

INSERT INTO cycling_table2
SELECT *,ROW_NUMBER() OVER(PARTITION BY trip_id) AS row_num
FROM current_table;






CREATE TABLE CURRENT_TABLE('tripid','Starttime','Endtime','Usertype','row_num')

SELECT *,ROW_NUMBER() OVER(PARTITION BY trip_id) AS row_num
FROM CURRENT_TABLE

SELECT *
FROM Duplicate_CTE
WHERE row_num>1

--Standardize_data

SELECT *
FROM cycling_table
WHERE usertype IS NULL;

SELECT *,DAYName(start_time) AS dayoftheweek
FROM cycling_table;

CREATE TABLE `cycling_table2` (
  `trip_id` int,
  `start_time` text,
  `end_time` text,
  `bikeid` int,
  `tripduration` bigint,
  `from_station_id` int,
  `from_station_name` text,
  `to_station_id` int,
  `to_station_name` text,
  `usertype` text,
  `gender` text,
  `birthyear` bigint,
  `dayoftheweek` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO cycling_table2
SELECT *,DAYName(start_time) AS dayoftheweek
FROM cycling_table;

SELECT *
FROM cycling_table2;

---Exploratory_data_analysis

SELECT *
FROM cycling_table2
WHERE usertype='Subscriber';

SELECT *
FROM cycling_table2
WHERE usertype='Customer';

SELECT usertype,SUM(tripduration)
FROM cycling_table2
GROUP BY usertype;

SELECT trip_id,usertype,tripduration
FROM cycling_table2
ORDER BY tripduration,usertype;


SELECT COUNT(trip_id) AS total,dayoftheweek,usertype
FROM cycling_table2
GROUP BY dayoftheweek,usertype
ORDER BY total DESC;


SELECT usertype,AVG(tripduration)
FROM cycling_table2
GROUP BY usertype;

SELECT COUNT(*)
FROM cycling_table2
WHERE usertype='Subscriber';

SELECT COUNT(*)
FROM cycling_table2
WHERE usertype='Customer';

SELECT usertype,MAX(tripduration)
FROM cycling_table2
GROUP BY usertype;

SELECT usertype,MIN(tripduration)
FROM cycling_table2
GROUP BY usertype;