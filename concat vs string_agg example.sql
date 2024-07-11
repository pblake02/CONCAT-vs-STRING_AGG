USE test;

-- CONCAT combines multiple expressions on a row by row basis outputing a result for each row
-- STRING_AGG combines multiple expressions into a single row result


-- Example 1
-- CONCAT combines multiple expressions on a row by row basis outputing a result for each row

 select CONCAT(id, ' § ', title)
  from album;

	--****** Results:   ******
	--  3 § Rubber Soul
	-- 13 § Birds of Fire
	-- 14 § Kind of Blue
	-- 16 § Live And
	-- 17 § Apostrophe
	-- 18 § Kind of Blue


---- Get column names from information_schema table (useful for building scripts)
  
  select * from information_schema.columns where table_name = 'album' OR  table_name = 'track';


-- Example 2
-- STRING_AGG combines multiple expressions into a single row result

---- Nesting CONCAT functions inside a STRING_AGG

  select 'SELECT' + char(10) +    -- char(10): line feed 
			STRING_AGG(
				CONCAT('case when ', information_schema.columns.COLUMN_NAME, ' <> ', information_schema.columns.COLUMN_NAME, ' then mismatch else null end as ', COLUMN_NAME),
				CONCAT(',', char(10))
			) + 
			char(10)
			+ 'FROM '
  from information_schema.columns where table_name = 'album';


	  --****** Results:   ******
	  -- SELECT 
	  -- case when id <> id then mismatch else null end as id,
	  -- case when title <> title then mismatch else null end as title,
	  -- case when artist <> artist then mismatch else null end as artist,
	  -- case when label <> label then mismatch else null end as label,
	  -- case when released <> released then mismatch else null end as released FROM 
