--there are multiple records for different statuses, but we don't need them for our purposes yet.
--if this table needs to be expended to include multiple rows per id, this will break downstream queries that depend
--on uniqueness on this id when joins are done.
select distinct
  id,
  account_id,
  adset_id,
  campaign_id,
  name,
  creative__id as creative_id,
  created_time as created_at,
  updated_time as updated_at
from
  {{ var('ads_table') }}
