{{ config(materialized='view') }}
DO $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM information_schema.columns
    WHERE table_name = 'schooldata'
      AND column_name = "States/
Union Territories"
  ) THEN
    EXECUTE 'ALTER TABLE schooldata RENAME COLUMN "States/
Union Territories" TO states_union_territories';
  END IF;
END
$$;

SELECT
  states_union_territories AS state,
  SUM("Primary Schools") AS total_primary_schools,
  SUM("Upper Primary Schools") AS total_upper_primary_schools,
  SUM("Pre-Primary Schools") AS total_pre_primary_schools,
  SUM("High/ Secondary Schools") AS total_high_secondary_schools
FROM {{ source('public', 'schooldata') }}
GROUP BY states_union_territories
