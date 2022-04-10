--had to do this when creating table from colab too
ALTER TABLE vine_table
  ALTER COLUMN star_rating TYPE varchar;
  
  -- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating VARCHAR,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

---------------------------------------------------------------------
--Steps 1-3--
SELECT *
FROM vine_table
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'Y'

---------------------------------------------------------------------

--Steps 1,2,4--
SELECT *
FROM vine_table
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'N'

---------------------------------------------------------------------

--Count of 5 star reviews (paid)--
SELECT COUNT (*)
FROM vine_table
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'Y'
AND star_rating = '5'

---------------------------------------------------------------------

--Step 5 (paid)
CREATE TEMP TABLE temp5 AS
SELECT *
FROM vine_table
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'Y'
AND star_rating = '5';
---------------------------------------------------------------------
CREATE TEMP TABLE temp6 AS
SELECT *
FROM vine_table vt
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'Y';
---------------------------------------------------------------------
select count (t5.star_rating), AS "Paid" count (t6.star_rating) AS "Total"
from temp5 t5
right join temp6 t6 on t6.review_id = t5.review_id

---------------------------------------------------------------------

--STEP 5 (Unpaid)--


CREATE TEMP TABLE temp5 AS
SELECT *
FROM vine_table
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'N'
AND star_rating = '5';
---------------------------------------------------------------------
CREATE TEMP TABLE temp6 AS
SELECT *
FROM vine_table vt
WHERE total_votes >20
AND CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5
AND vine = 'N';
---------------------------------------------------------------------
select count (t5.star_rating) AS "Unpaid", count (t6.star_rating) AS "total"
from temp5 t5
right join temp6 t6 on t6.review_id = t5.review_id

