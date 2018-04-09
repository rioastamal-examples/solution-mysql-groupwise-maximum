-- Author       : Rio Astamal <rio@rioastamal.net>
-- Description  : Solution to SQL group-wise maximum problem
-- Link         : https://github.com/rioastamal-examples/solution-mysql-groupwise-maximum
-- Article      : https://www.linkedin.com/pulse/mysql-group-wise-maximum-query-nilai-tertinggi-pada-setiap-astamal/

-- First, Let's display all top scores data to get some insight
USE `groupwise_example`;
SELECT * FROM `top_scores`;
--
-- +----+------------------+-------------------+-----------+-------+
-- | id | player           | club              | season    | goals |
-- +----+------------------+-------------------+-----------+-------+
-- |  1 | Alexis Sanchez   | Arsenal           | 2015-2016 |    13 |
-- |  2 | Troy Deeney      | Watford           | 2015-2016 |    13 |
-- |  3 | Romelu Lukaku    | Everton           | 2015-2016 |    18 |
-- |  4 | Harry Kane       | Tottenham Hotspur | 2015-2016 |    25 |
-- |  5 | Oliver Giroud    | Arsenal           | 2015-2016 |    16 |
-- |  6 | Anthony Martial  | Manchester United | 2015-2016 |    11 |
-- |  7 | Riyad Mahrez     | Leicester City    | 2015-2016 |    17 |
-- |  8 | Gylfi Sigurdsson | Swansea City      | 2015-2016 |    11 |
-- |  9 | Jamie Vardy      | Leicester City    | 2015-2016 |    24 |
-- | 10 | Odion Ighalo     | Watford           | 2015-2016 |    15 |
-- | 11 | André Ayew       | Swansea City      | 2015-2016 |    12 |
-- | 12 | Diego Costa      | Chelsea           | 2015-2016 |    12 |
-- +----+------------------+-------------------+-----------+-------+
-- 12 rows in set (0.00 sec)

-- Problem
-- I want to show highest top scorer grouped by each club
--
-- Expected Result
-- +----+-----------------+-------------------+-----------+-------+
-- | id | player          | club              | season    | goals |
-- +----+-----------------+-------------------+-----------+-------+
-- |  4 | Harry Kane      | Tottenham Hotspur | 2015-2016 |    25 |
-- |  9 | Jamie Vardy     | Leicester City    | 2015-2016 |    24 |
-- |  3 | Romelu Lukaku   | Everton           | 2015-2016 |    18 |
-- |  5 | Oliver Giroud   | Arsenal           | 2015-2016 |    16 |
-- | 10 | Odion Ighalo    | Watford           | 2015-2016 |    15 |
-- | 11 | André Ayew      | Swansea City      | 2015-2016 |    12 |
-- | 12 | Diego Costa     | Chelsea           | 2015-2016 |    12 |
-- |  6 | Anthony Martial | Manchester United | 2015-2016 |    11 |
-- +----+-----------------+-------------------+-----------+-------+
-- 8 rows in set (0.01 sec)

-- It seems easy by using group by and order, ok let's try it!
SELECT `id`, `player`, `club`, `season`, MAX(`goals`) AS `goals`
FROM `top_scores` GROUP BY `club` ORDER BY `goals` DESC;
--
-- Wrong Result
-- +----+------------------+-------------------+-----------+-------+
-- | id | player           | club              | season    | goals |
-- +----+------------------+-------------------+-----------+-------+
-- |  4 | Harry Kane       | Tottenham Hotspur | 2015-2016 |    25 |
-- |  3 | Romelu Lukaku    | Everton           | 2015-2016 |    18 |
-- |  7 | Riyad Mahrez     | Leicester City    | 2015-2016 |    17 |
-- |  1 | Alexis Sanchez   | Arsenal           | 2015-2016 |    13 |
-- |  2 | Troy Deeney      | Watford           | 2015-2016 |    13 |
-- | 12 | Diego Costa      | Chelsea           | 2015-2016 |    12 |
-- |  8 | Gylfi Sigurdsson | Swansea City      | 2015-2016 |    11 |
-- |  6 | Anthony Martial  | Manchester United | 2015-2016 |    11 |
-- +----+------------------+-------------------+-----------+-------+
-- 8 rows in set (0.00 sec)

-- Did you notice something wrong with the result above? No?
-- Take a look again for row #3 (id 7) and row #7 (id 8)
-- Row #3 should be Jamie Vardy NOT Riyad Mahrez
-- Row #7 should be André Ayew NOT Gylfi Sigurdsson

-- How does we solve it?
-- Let's break down the steps to make it simpler

-- Step #1
-- Get the highest goals grouped by club, we do not need ordering at this point
SELECT `club`, MAX(`goals`) AS `max_goals` FROM `top_scores` GROUP BY `club`;
--
-- Result #1
-- +-------------------+-------+
-- | club              | goals |
-- +-------------------+-------+
-- | Arsenal           |    16 |
-- | Chelsea           |    12 |
-- | Everton           |    18 |
-- | Leicester City    |    24 |
-- | Manchester United |    11 |
-- | Swansea City      |    12 |
-- | Tottenham Hotspur |    25 |
-- | Watford           |    15 |
-- +-------------------+-------+
-- 8 rows in set (0.00 sec)

-- Step #2
-- We will do self join with Result #1, we will only match records which has
-- the same club name and number of goals
SELECT `ts1`.*
FROM `top_scores` AS `ts1`
INNER JOIN (
  SELECT `club`, MAX(`goals`) AS `max_goals` FROM `top_scores`
  GROUP BY `club`
) AS `ts2` ON `ts2`.`club`=`ts1`.`club` AND `ts2`.`max_goals`=`ts1`.`goals`
ORDER by `ts1`.`goals` DESC;
--
-- +----+-----------------+-------------------+-----------+-------+
-- | id | player          | club              | season    | goals |
-- +----+-----------------+-------------------+-----------+-------+
-- |  4 | Harry Kane      | Tottenham Hotspur | 2015-2016 |    25 |
-- |  9 | Jamie Vardy     | Leicester City    | 2015-2016 |    24 |
-- |  3 | Romelu Lukaku   | Everton           | 2015-2016 |    18 |
-- |  5 | Oliver Giroud   | Arsenal           | 2015-2016 |    16 |
-- | 10 | Odion Ighalo    | Watford           | 2015-2016 |    15 |
-- | 11 | André Ayew      | Swansea City      | 2015-2016 |    12 |
-- | 12 | Diego Costa     | Chelsea           | 2015-2016 |    12 |
-- |  6 | Anthony Martial | Manchester United | 2015-2016 |    11 |
-- +----+-----------------+-------------------+-----------+-------+
-- 8 rows in set (0.01 sec)
--
-- Now we got result as expecte