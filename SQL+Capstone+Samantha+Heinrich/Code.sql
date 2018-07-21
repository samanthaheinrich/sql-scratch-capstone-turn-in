SELECT COUNT (DISTINCT utm_campaign) AS 'Number of Campaigns'
FROM page_visits;
SELECT COUNT (DISTINCT utm_source) AS 'Number of Sources'
FROM page_visits;
SELECT utm_source, 
     utm_campaign
FROM page_visits
GROUP BY utm_campaign;
SELECT DISTINCT page_name AS 'Page Names'
FROM page_visits;
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) AS 'first_touch_at'
    FROM page_visits
    GROUP BY user_id), 
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp)
SELECT ft_attr.utm_source AS 'Source',
       ft_attr.utm_campaign 'Campaign',
       COUNT(*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id), 
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
  			 pv.page_name
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_source AS 'Source',
       lt_attr.utm_campaign 'Campaign',
       COUNT(*) 
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;
SELECT COUNT(*)
FROM page_visits
WHERE page_name = '4 - purchase';
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) AS 'last_touch_at'
    FROM page_visits
    GROUP BY user_id), 
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign,
  			 pv.page_name
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp)
SELECT lt_attr.utm_source AS 'Source',
       lt_attr.utm_campaign 'Campaign',
       COUNT(*) 
FROM lt_attr
WHERE page_name = '4 - purchase'
GROUP BY 1, 2
ORDER BY 3 DESC;
