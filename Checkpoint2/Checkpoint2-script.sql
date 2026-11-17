-- ============================================================================
-- CSE 111 Fall 2026: Project Checkpoint 2 Script
-- Project Title: F1 Fan Analytics Database
-- Team Members: Nathan Delgado, Eliud Hadgu
-- File: Checkpoint2-script.sql
-- ============================================================================

-- ============================================================================
-- SCHEMA MODIFICATIONS SINCE CHECKPOINT 1
-- ============================================================================
-- Modifications:
-- 1. Added Result to implement the Records Result relationship between Race,
--    Driver, and Team. Its primary key is (race_id, driver_id); it stores grid
--    position, finish position, points, and status, with foreign keys to all
--    three entities and checks for positive positions and nonnegative points.
-- 2. Corrected Engine-Supplier to Engine_Supplier in that table's definition to make it valid SQLite SQL.
-- 3. Added CHECK (length_km > 0) to Circuit.
-- ============================================================================

-- ============================================================================
-- MEMBER CONTRIBUTIONS SUMMARY
-- ============================================================================
--
-- SECTION 1: SIMPLE STATEMENTS
-- Statement 01: Nathan Delgado: 0%,   Eliud Hadgu: 100%
-- Statement 02: Nathan Delgado: 100%, Eliud Hadgu: 0%
-- Statement 03: Nathan Delgado: 100%, Eliud Hadgu: 0%
-- Statement 04: Nathan Delgado: 100%, Eliud Hadgu: 0%
-- Statement 05: Nathan Delgado: 100%, Eliud Hadgu: 0%
-- Statement 06: Nathan Delgado: 0%,   Eliud Hadgu: 100%
-- Statement 07: Nathan Delgado: 100%, Eliud Hadgu: 0%
-- Statement 08: Nathan Delgado: 0%,   Eliud Hadgu: 100%
-- Statement 09: Nathan Delgado: 0%,   Eliud Hadgu: 100%
-- Statement 10: Nathan Delgado: 0%,   Eliud Hadgu: 100%
--
-- SECTION 2: INTERMEDIATE STATEMENTS
-- Statement 11: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 12: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 13: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 14: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 15: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 16: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 17: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 18: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 19: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 20: Nathan Delgado: 50%, Eliud Hadgu: 50%
--
-- SECTION 3: COMPLEX STATEMENTS
-- Statement 21: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 22: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 23: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 24: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 25: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 26: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 27: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 28: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 29: Nathan Delgado: 50%, Eliud Hadgu: 50%
-- Statement 30: Nathan Delgado: 50%, Eliud Hadgu: 50%
--
-- ============================================================================
PRAGMA foreign_keys = ON;
.headers on
.mode column
SAVEPOINT checkpoint2_examples;

-- ============================================================================
-- SECTION 1: SIMPLE STATEMENTS (01-10)
-- Focus: Single-table projections/filters, single-row DML, ordering,
--        scalar aggregates, and pattern matching.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 01: Driver Names and Nationalities
-- Explanation: List each driver's name and nationality using a single-table
--              projection.
-- ----------------------------------------------------------------------------
.print "Statement 01"
SELECT first_name, last_name, nationality
FROM Driver;

-- ----------------------------------------------------------------------------
-- Statement 02: British Drivers
-- Explanation: Find British drivers and order them alphabetically by surname.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 02"
SELECT driver_id, first_name, last_name
FROM Driver
WHERE nationality = 'British'
ORDER BY last_name, first_name, driver_id;

-- ----------------------------------------------------------------------------
-- Statement 03: Circuits Ordered by Length
-- Explanation: List circuits from longest to shortest, with their countries.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 03"
SELECT circuit_name, country, length_km
FROM Circuit
ORDER BY length_km DESC, circuit_id;

-- ----------------------------------------------------------------------------
-- Statement 04: Recorded Result Count
-- Explanation: Count the number of race-result records in the sample database.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 04"
SELECT COUNT(*) AS result_count
FROM Result;

-- ----------------------------------------------------------------------------
-- Statement 05: Total Sample Points
-- Explanation: Calculate the total points awarded across all recorded results.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 05"
SELECT COALESCE(SUM(points), 0) AS total_sample_points
FROM Result;

-- ----------------------------------------------------------------------------
-- Statement 06: Sponsor Name Pattern Matching
-- Explanation: Find sponsors whose names contain the word Oil using pattern
--              matching.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 06"
SELECT sponsor_id, sponsor_name, industry
FROM Sponsor
WHERE sponsor_name LIKE '%Oil%'
ORDER BY sponsor_name, sponsor_id;

-- ----------------------------------------------------------------------------
-- Statement 07: Races Held in 2024
-- Explanation: Retrieve races held during 2024 using an inclusive/exclusive
--              date range.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 07"
SELECT race_name, round_number, race_date
FROM Race
WHERE race_date >= '2024-01-01'
  AND race_date < '2025-01-01'
ORDER BY race_date, race_id;

-- ----------------------------------------------------------------------------
-- Statement 08: Insert a Demonstration Sponsor
-- Explanation: Insert a fictional sponsor for the next two single-row DML
--              examples. The demonstration ID is unused in the supplied
--              database.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 08"
INSERT INTO Sponsor (sponsor_id, sponsor_name, industry)
VALUES (900001, 'Checkpoint Demo Sponsor', 'Technology');
-- Report how many sponsors the preceding insert created.
SELECT changes() AS sponsors_inserted;

-- ----------------------------------------------------------------------------
-- Statement 09: Update the Demonstration Sponsor
-- Explanation: Change the fictional sponsor's industry using its primary key.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 09"
UPDATE Sponsor
SET industry = 'Analytics'
WHERE sponsor_id = 900001;
-- Report how many sponsors the preceding single-row update changed.
SELECT changes() AS sponsors_updated;

-- ----------------------------------------------------------------------------
-- Statement 10: Delete the Demonstration Sponsor
-- Explanation: Delete the fictional sponsor after demonstrating INSERT and
--              UPDATE.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 10"
DELETE FROM Sponsor
WHERE sponsor_id = 900001;
-- Report how many demonstration sponsors the preceding delete removed.
SELECT changes() AS sponsors_deleted;

-- ============================================================================
-- SECTION 2: INTERMEDIATE STATEMENTS (11-20)
-- Focus: Inner and left joins, GROUP BY/HAVING, scalar subqueries,
--        table aliasing, and conditional updates.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 11: Race Calendar with Season and Circuit
-- Explanation: Join races to seasons and circuits to show the sample race
--              calendar.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 11"
SELECT s.season_year, r.round_number, r.race_name,
       r.race_date, c.circuit_name, c.country
FROM Race AS r
JOIN Season AS s ON s.season_id = r.season_id
JOIN Circuit AS c ON c.circuit_id = r.circuit_id
ORDER BY s.season_year, r.round_number, r.race_id;

-- ----------------------------------------------------------------------------
-- Statement 12: Podium Results with Drivers and Teams
-- Explanation: Show podium finishers with their drivers, race-day teams, and
--              races. Using Result.team_id preserves the team recorded for
--              each race.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 12"
SELECT r.race_date, r.race_name, d.first_name, d.last_name,
       t.team_name, res.finish_position, res.points
FROM Result AS res
JOIN Driver AS d ON d.driver_id = res.driver_id
JOIN Team AS t ON t.team_id = res.team_id
JOIN Race AS r ON r.race_id = res.race_id
WHERE res.finish_position BETWEEN 1 AND 3
ORDER BY r.race_date, r.race_id, res.finish_position, d.driver_id;

-- ----------------------------------------------------------------------------
-- Statement 13: Team Sponsors Including Unmatched Teams
-- Explanation: List each team's sponsors as of January 1, 2024, retaining
--              teams with no sponsorship recorded for that date through LEFT
--              JOIN.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 13"
SELECT t.team_name, sp.sponsor_name
FROM Team AS t
LEFT JOIN Sponsored_By AS sb
  ON sb.team_id = t.team_id
 AND sb.start_date <= '2024-01-01'
 AND (sb.end_date IS NULL OR sb.end_date >= '2024-01-01')
LEFT JOIN Sponsor AS sp ON sp.sponsor_id = sb.sponsor_id
ORDER BY t.team_name, sp.sponsor_name, t.team_id, sp.sponsor_id;

-- ----------------------------------------------------------------------------
-- Statement 14: Driver Points Including Nonparticipants
-- Explanation: Total each driver's sample points, including drivers without
--              results.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 14"
SELECT d.driver_id, d.first_name, d.last_name,
       COUNT(res.race_id) AS recorded_starts,
       COALESCE(SUM(res.points), 0) AS total_points
FROM Driver AS d
LEFT JOIN Result AS res ON res.driver_id = d.driver_id
GROUP BY d.driver_id, d.first_name, d.last_name
ORDER BY total_points DESC, d.driver_id;

-- ----------------------------------------------------------------------------
-- Statement 15: Teams Meeting a Points Threshold
-- Explanation: Find teams with at least 100 points in the sample using GROUP
--              BY and HAVING to filter aggregated totals.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 15"
SELECT t.team_id, t.team_name, SUM(res.points) AS total_points
FROM Team AS t
JOIN Result AS res ON res.team_id = t.team_id
GROUP BY t.team_id, t.team_name
HAVING SUM(res.points) >= 100
ORDER BY total_points DESC, t.team_id;

-- ----------------------------------------------------------------------------
-- Statement 16: Results Above Average Points
-- Explanation: Find individual results that scored above the average points
--              per recorded result, calculated by an uncorrelated scalar
--              subquery.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 16"
SELECT r.race_date, r.race_name, d.first_name, d.last_name, res.points
FROM Result AS res
JOIN Race AS r ON r.race_id = res.race_id
JOIN Driver AS d ON d.driver_id = res.driver_id
WHERE res.points > (SELECT AVG(points) FROM Result)
ORDER BY res.points DESC, r.race_date, r.race_id, d.driver_id;

-- ----------------------------------------------------------------------------
-- Statement 17: Engine Supply on a Specified Date
-- Explanation: Show each team's engine supplier and model as of January 1,
--              2024. Start/end date filtering excludes historical supply
--              arrangements.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 17"
SELECT t.team_name, es.supplier_name, ue.engine_model
FROM Uses_Engine AS ue
JOIN Team AS t ON t.team_id = ue.team_id
JOIN Engine_Supplier AS es ON es.supplier_id = ue.supplier_id
WHERE ue.start_date <= '2024-01-01'
  AND (ue.end_date IS NULL OR ue.end_date >= '2024-01-01')
ORDER BY t.team_name, es.supplier_name, ue.start_date;

-- ----------------------------------------------------------------------------
-- Statement 18: Conditional Sponsor Industry Update
-- Explanation: Reclassify energy sponsors with a recorded open-ended
--              sponsorship using a conditional update with a subquery; cleanup
--              restores the old values.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 18"
UPDATE Sponsor
SET industry = 'Energy / Fuels'
WHERE industry = 'Energy'
  AND sponsor_id IN (
      SELECT sponsor_id
      FROM Sponsored_By
      WHERE end_date IS NULL
  );
-- Report how many sponsors the preceding conditional update changed.
SELECT changes() AS sponsors_updated;

-- ----------------------------------------------------------------------------
-- Statement 19: Season Participation Summary
-- Explanation: Count recorded races and participating drivers in each season,
--              retaining seasons that have no sample races or results.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 19"
SELECT s.season_year, COUNT(DISTINCT r.race_id) AS recorded_races,
       COUNT(DISTINCT res.driver_id) AS participating_drivers,
       COALESCE(SUM(res.points), 0) AS total_points
FROM Season AS s
LEFT JOIN Race AS r ON r.season_id = s.season_id
LEFT JOIN Result AS res ON res.race_id = r.race_id
GROUP BY s.season_id, s.season_year
ORDER BY s.season_year;

-- ----------------------------------------------------------------------------
-- Statement 20: Teammate Pairs on a Specified Date
-- Explanation: Find teammate pairs as of March 1, 2024, by joining Drives_For
--              to itself; driver-ID ordering lists each pair once.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 20"
SELECT t.team_name,
       d1.first_name || ' ' || d1.last_name AS first_driver,
       d2.first_name || ' ' || d2.last_name AS second_driver
FROM Drives_For AS df1
JOIN Drives_For AS df2
  ON df2.team_id = df1.team_id
 AND df1.driver_id < df2.driver_id
JOIN Team AS t ON t.team_id = df1.team_id
JOIN Driver AS d1 ON d1.driver_id = df1.driver_id
JOIN Driver AS d2 ON d2.driver_id = df2.driver_id
WHERE df1.start_date <= '2024-03-01'
  AND (df1.end_date IS NULL OR df1.end_date >= '2024-03-01')
  AND df2.start_date <= '2024-03-01'
  AND (df2.end_date IS NULL OR df2.end_date >= '2024-03-01')
ORDER BY t.team_name, d1.driver_id, d2.driver_id;

-- ============================================================================
-- SECTION 3: COMPLEX STATEMENTS (21-30)
-- Focus: Correlated subqueries, set operations, CTEs, window functions,
--        view creation/querying, and conditional CASE expressions.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Statement 21: Drivers with Recorded Wins Using EXISTS
-- Explanation: Find drivers with at least one recorded race win using a
--              correlated EXISTS subquery, which returns each qualifying
--              driver only once.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 21"
SELECT d.driver_id, d.first_name, d.last_name
FROM Driver AS d
WHERE EXISTS (
    SELECT 1
    FROM Result AS res
    WHERE res.driver_id = d.driver_id
      AND res.finish_position = 1
)
ORDER BY d.last_name, d.first_name, d.driver_id;

-- ----------------------------------------------------------------------------
-- Statement 22: Drivers Without Results Using NOT EXISTS
-- Explanation: Find drivers without any recorded results using correlated NOT
--              EXISTS.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 22"
SELECT d.driver_id, d.first_name, d.last_name
FROM Driver AS d
WHERE NOT EXISTS (
    SELECT 1
    FROM Result AS res
    WHERE res.driver_id = d.driver_id
)
ORDER BY d.last_name, d.first_name, d.driver_id;

-- ----------------------------------------------------------------------------
-- Statement 23: Organization Names Using UNION
-- Explanation: Combine sponsor names and engine-supplier names into a distinct
--              organization-name list using UNION.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 23"
SELECT sponsor_name AS organization_name
FROM Sponsor
UNION
SELECT supplier_name AS organization_name
FROM Engine_Supplier
ORDER BY organization_name;

-- ----------------------------------------------------------------------------
-- Statement 24: Drivers in Both Seasons Using INTERSECT
-- Explanation: Find drivers who have recorded results in both 2023 and 2024
--              using INTERSECT on the two season-specific driver sets.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 24"
SELECT d.driver_id, d.first_name, d.last_name
FROM Driver AS d
JOIN Result AS res ON res.driver_id = d.driver_id
JOIN Race AS r ON r.race_id = res.race_id
JOIN Season AS s ON s.season_id = r.season_id
WHERE s.season_year = 2023
INTERSECT
SELECT d.driver_id, d.first_name, d.last_name
FROM Driver AS d
JOIN Result AS res ON res.driver_id = d.driver_id
JOIN Race AS r ON r.race_id = res.race_id
JOIN Season AS s ON s.season_id = r.season_id
WHERE s.season_year = 2024
ORDER BY 1;

-- ----------------------------------------------------------------------------
-- Statement 25: Drivers Without Podiums Using EXCEPT
-- Explanation: Find drivers without a recorded podium by subtracting podium
--              drivers from the complete driver set using EXCEPT; drivers with
--              no starts remain.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 25"
SELECT driver_id, first_name, last_name
FROM Driver
EXCEPT
SELECT d.driver_id, d.first_name, d.last_name
FROM Driver AS d
JOIN Result AS res ON res.driver_id = d.driver_id
WHERE res.finish_position BETWEEN 1 AND 3
ORDER BY driver_id;

-- ----------------------------------------------------------------------------
-- Statement 26: Team Points Comparison Using a CTE
-- Explanation: Use a CTE to total team points by season, then compare 2024
--              with 2023. The difference compares supplied sample races, not
--              full-season performance.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 26"
WITH team_season_points AS (
    SELECT res.team_id, s.season_year, SUM(res.points) AS total_points
    FROM Result AS res
    JOIN Race AS r ON r.race_id = res.race_id
    JOIN Season AS s ON s.season_id = r.season_id
    GROUP BY res.team_id, s.season_year
)
SELECT t.team_name, p23.total_points AS points_2023,
       p24.total_points AS points_2024,
       p24.total_points - p23.total_points AS point_difference
FROM team_season_points AS p23
JOIN team_season_points AS p24 ON p24.team_id = p23.team_id
JOIN Team AS t ON t.team_id = p23.team_id
WHERE p23.season_year = 2023
  AND p24.season_year = 2024
ORDER BY point_difference DESC, t.team_id;

-- ----------------------------------------------------------------------------
-- Statement 27: Season Points Ranking Using DENSE_RANK
-- Explanation: Rank drivers by sample points within each season using
--              DENSE_RANK. Tied point totals receive the same rank without
--              gaps in the next rank.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 27"
SELECT s.season_year, d.driver_id, d.first_name, d.last_name,
       SUM(res.points) AS total_points,
       DENSE_RANK() OVER (
           PARTITION BY s.season_id
           ORDER BY SUM(res.points) DESC
       ) AS sample_points_rank
FROM Result AS res
JOIN Driver AS d ON d.driver_id = res.driver_id
JOIN Race AS r ON r.race_id = res.race_id
JOIN Season AS s ON s.season_id = r.season_id
GROUP BY s.season_id, s.season_year, d.driver_id, d.first_name, d.last_name
ORDER BY s.season_year, sample_points_rank, d.driver_id;

-- ----------------------------------------------------------------------------
-- Statement 28: Best Circuit Finishes Using ROW_NUMBER
-- Explanation: Find each driver's best classified finish at each circuit using
--              a CTE and ROW_NUMBER; ties prefer the earlier race date, then
--              the smaller race ID.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 28"
WITH ranked_finishes AS (
    SELECT res.driver_id, r.circuit_id, r.race_id, r.race_date,
           res.finish_position,
           ROW_NUMBER() OVER (
               PARTITION BY res.driver_id, r.circuit_id
               ORDER BY res.finish_position, r.race_date, r.race_id
           ) AS finish_order
    FROM Result AS res
    JOIN Race AS r ON r.race_id = res.race_id
    WHERE res.finish_position IS NOT NULL
)
SELECT d.first_name, d.last_name, c.circuit_name,
       rf.finish_position AS best_finish, rf.race_date
FROM ranked_finishes AS rf
JOIN Driver AS d ON d.driver_id = rf.driver_id
JOIN Circuit AS c ON c.circuit_id = rf.circuit_id
WHERE rf.finish_order = 1
ORDER BY c.circuit_name, best_finish, d.driver_id, c.circuit_id;

-- ----------------------------------------------------------------------------
-- Statement 29: Create a Driver Season Summary View
-- Explanation: Define a reusable view summarizing each participating driver's
--              sample starts, points, and wins per season; final cleanup
--              removes this example view.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 29"
CREATE VIEW Checkpoint2_Driver_Season_Summary AS
SELECT s.season_year, d.driver_id, d.first_name, d.last_name,
       COUNT(*) AS recorded_starts,
       SUM(res.points) AS total_points,
       SUM(CASE WHEN res.finish_position = 1 THEN 1 ELSE 0 END) AS wins
FROM Result AS res
JOIN Driver AS d ON d.driver_id = res.driver_id
JOIN Race AS r ON r.race_id = res.race_id
JOIN Season AS s ON s.season_id = r.season_id
GROUP BY s.season_id, s.season_year, d.driver_id, d.first_name, d.last_name;
-- Confirm that the preceding statement created the demonstration view.
SELECT name AS created_view
FROM sqlite_schema
WHERE type = 'view' AND name = 'Checkpoint2_Driver_Season_Summary';

-- ----------------------------------------------------------------------------
-- Statement 30: Classify Driver Season Summaries Using CASE
-- Explanation: Query the summary view and use CASE to classify each driver's
--              season sample as a race winner, a points scorer without a win,
--              or a non-scorer.
-- ----------------------------------------------------------------------------
.print ''
.print "Statement 30"
SELECT season_year, first_name, last_name, recorded_starts, total_points, wins,
       CASE
           WHEN wins > 0 THEN 'Race winner'
           WHEN total_points > 0 THEN 'Points scorer without a win'
           ELSE 'No points in sample'
       END AS sample_category
FROM Checkpoint2_Driver_Season_Summary
ORDER BY season_year, total_points DESC, driver_id;

-- Restore the original sample rows and remove the demonstration view.
ROLLBACK TO SAVEPOINT checkpoint2_examples;

-- Close the savepoint after cleanup so no transaction is left open.
RELEASE SAVEPOINT checkpoint2_examples;
