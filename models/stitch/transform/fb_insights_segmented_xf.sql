with ads as (

  select * from {{ref('fb_ads_xf')}}

), creatives as (

  select * from {{ref('fb_ad_creatives')}}

), insights as (

  select * from {{ref('fb_insights_segmented')}}

)
select
  md5(insights.date_day || '|' || ads.unique_id || '|' || insights.segment_type || '|' || insights.segment) as id,
  insights.*,
  creatives.base_url,
  creatives.url,
  creatives.utm_medium,
  creatives.utm_source,
  creatives.utm_campaign,
  creatives.utm_content,
  creatives.utm_term,
  ads.unique_id as ad_unique_id
from insights
  left outer join ads
    on insights.ad_id = ads.id
    and insights.date_day >= date_trunc('day', ads.effective_from)::date
    and (insights.date_day < date_trunc('day', ads.effective_to)::date or ads.effective_to is null)
  inner join creatives on ads.creative_id = creatives.id
