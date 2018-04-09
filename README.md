## About

This example contains solution for SQL problem commonly known as Group-wise
Maximum. We want to find the highest row in each group of rows. The solution
shown here are using simple _self join_. Suppose we have sample data like
below.

```
+----+------------------+-------------------+-----------+-------+
| id | player           | club              | season    | goals |
+----+------------------+-------------------+-----------+-------+
|  1 | Alexis Sanchez   | Arsenal           | 2015-2016 |    13 |
|  2 | Troy Deeney      | Watford           | 2015-2016 |    13 |
|  3 | Romelu Lukaku    | Everton           | 2015-2016 |    18 |
|  4 | Harry Kane       | Tottenham Hotspur | 2015-2016 |    25 |
|  5 | Oliver Giroud    | Arsenal           | 2015-2016 |    16 |
|  6 | Anthony Martial  | Manchester United | 2015-2016 |    11 |
|  7 | Riyad Mahrez     | Leicester City    | 2015-2016 |    17 |
|  8 | Gylfi Sigurdsson | Swansea City      | 2015-2016 |    11 |
|  9 | Jamie Vardy      | Leicester City    | 2015-2016 |    24 |
| 10 | Odion Ighalo     | Watford           | 2015-2016 |    15 |
| 11 | André Ayew       | Swansea City      | 2015-2016 |    12 |
| 12 | Diego Costa      | Chelsea           | 2015-2016 |    12 |
+----+------------------+-------------------+-----------+-------+
```

We want to have highest top scorer grouped by each club. The expected result
are shown below.

```
+----+-----------------+-------------------+-----------+-------+
| id | player          | club              | season    | goals |
+----+-----------------+-------------------+-----------+-------+
|  4 | Harry Kane      | Tottenham Hotspur | 2015-2016 |    25 |
|  9 | Jamie Vardy     | Leicester City    | 2015-2016 |    24 |
|  3 | Romelu Lukaku   | Everton           | 2015-2016 |    18 |
|  5 | Oliver Giroud   | Arsenal           | 2015-2016 |    16 |
| 10 | Odion Ighalo    | Watford           | 2015-2016 |    15 |
| 11 | André Ayew      | Swansea City      | 2015-2016 |    12 |
| 12 | Diego Costa     | Chelsea           | 2015-2016 |    12 |
|  6 | Anthony Martial | Manchester United | 2015-2016 |    11 |
+----+-----------------+-------------------+-----------+-------+
```

The query to get the result above are as follow. The table name are
_top_scores_.

```
SELECT `ts1`.*
FROM `top_scores` AS `ts1`
INNER JOIN (
  SELECT `club`, MAX(`goals`) AS `max_goals` FROM `top_scores`
  GROUP BY `club`
) AS `ts2` ON `ts2`.`club`=`ts1`.`club` AND `ts2`.`max_goals`=`ts1`.`goals`
ORDER by `ts1`.`goals` DESC;
```

# Read More

My complete article about MySQL Group-wise Maximum solution can be found
on link below.

https://www.linkedin.com/pulse/mysql-group-wise-maximum-query-nilai-tertinggi-pada-setiap-astamal/

## Author

This example is written by Rio Astamal <rio@rioastamal.net>