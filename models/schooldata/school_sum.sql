-- {{ config(materialized='view')}}
{{ config(
    materialized='view',
    pre_hook=["ALTER TABLE schooldata RENAME COLUMN \"States/\nUnion Territories\" TO states_union_territories"]
) }}


SELECT
  states_union_territories AS state,
  SUM("Primary Schools") AS total_primary_schools,
  SUM("Upper Primary Schools") AS total_upper_primary_schools,
  SUM("Pre-Primary Schools") AS total_pre_primary_schools,
  SUM("High/ Secondary Schools") AS total_high_secondary_schools
FROM {{ source('public', 'schooldata') }}
GROUP BY states_union_territories