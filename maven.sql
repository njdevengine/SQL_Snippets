-- get count of unique sessions by traffic source

select utm_content, count(distinct website_session_id) as sessions
from website_sessions
where user_id between 1000 and 2000
group by
utm_content
order by count(distinct website_session_id) desc;

-- same as above with group by order by shorthand

select
	utm_content,
	count(distinct website_session_id) as sessions
from website_sessions
where user_id between 1000 and 2000
group by 1
order by 2 desc;

-- getting a column of sessions and orders from those sessions (i.e. sessions to purchase conversion by source)

select
	website_sessions.utm_content,
	count(distinct website_sessions.website_session_id) as sessions,
    count(distinct orders.order_id) as orders
from website_sessions
	left join orders on
		orders.website_session_id = website_sessions.website_session_id
where website_sessions.website_session_id between 1000 and 2000
group by 1
order by 2 desc;

-- like above with a conversion rate
select
	website_sessions.utm_content,
	count(distinct website_sessions.website_session_id) as sessions,
    count(distinct orders.order_id) as orders,
    count(distinct orders.order_id)/count(distinct website_sessions.website_session_id) as conversion_rate
from website_sessions
	left join orders on
		orders.website_session_id = website_sessions.website_session_id
where website_sessions.website_session_id between 1000 and 2000
group by 1
order by 2 desc;

-- get number of sessions by referer sources

select
utm_source,
utm_campaign,
http_referer,
count(distinct website_session_id) as sessions
from website_sessions
group by 1,2,3
order by 4 desc;

-- get number of sessions from referral sources that resulted in an order
select
	utm_source,
	utm_campaign,
	http_referer,
	count(distinct website_session_id) as sessions
from website_sessions
where exists(select * from orders where orders.website_session_id=website_sessions.website_session_id)
group by 1,2,3
order by 4 desc;

-- same as above before a certain date
select
	utm_source,
	utm_campaign,
	http_referer,
	count(distinct website_session_id) as sessions
from website_sessions
where created_at < '2012-04-12'
group by 1,2,3;

-- get conversion rates i.e. sessions to orders for gsearch/nonbrand sessions

select 
	count(distinct website_sessions.website_session_id) as sessions,
	count(distinct orders.website_session_id) as orders,
	count(distinct orders.website_session_id)/count(distinct website_sessions.website_session_id) as conv_rate
from website_sessions
left join orders on orders.website_session_id = website_sessions.website_session_id
where website_sessions.utm_source = "gsearch" and website_sessions.utm_campaign = "nonbrand"
;

-- same with date filter

select 
	count(distinct website_sessions.website_session_id) as sessions,
	count(distinct orders.website_session_id) as orders,
	count(distinct orders.website_session_id)/count(distinct website_sessions.website_session_id) as conv_rate
from website_sessions
left join orders on orders.website_session_id = website_sessions.website_session_id
where website_sessions.utm_source = "gsearch" and website_sessions.utm_campaign = "nonbrand"
AND website_sessions.created_at < '2012-04-14'
;

-- aggregate total weekly website visits, gets start date for week
select
    year(created_at),
	week(created_at),
    min(date(created_at)) as week_of,
	count(distinct website_session_id) as sessions
from website_sessions
where website_session_id between 100000 and 115000
group by 1,2;
	     
-- for the four products get count of single and mutli item orders using case when
-- its like a pivot table where you add columns

select
primary_product_id,
count(distinct case when items_purchased = 1 then order_id else null end) as single_item_orders,
count(distinct case when items_purchased >=2 then order_id else null end) as multi_item_orders
from orders
group by 1
;
	     
-- view weekly sessions between date range
	     
select
week(created_at),
min(date(created_at)) as week_of,
count(distinct website_session_id) as sessions
from website_sessions
where website_sessions.utm_source = "gsearch" and website_sessions.utm_campaign = "nonbrand"
and created_at >= '2012-04-15' and created_at <= '2012-05-10'
group by week(created_at)
order by week_of desc
;
	 
-- get sessions, orders and conversion rate by device type
	 
select website_sessions.device_type,
count(distinct website_sessions.website_session_id) as sessions,
count(distinct orders.website_session_id) as orders,
count(distinct orders.website_session_id)/count(distinct website_sessions.website_session_id) as conversion_rate
from website_sessions
left join orders on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at <= '2012-05-11' -- and website_sessions.created_at >= '2012-04-15'
and website_sessions.utm_source = 'gsearch'
and website_sessions.utm_campaign = 'nonbrand'
group by 1
;

-- get breakdown of sessions by week with total desktop and mobile sessions weekly
	 
select
min(date(created_at)),
-- count(distinct website_session_id) as sessions,
count(distinct case when device_type = 'desktop' then website_session_id else null end) as desktop_session,
count(distinct case when device_type = 'mobile' then website_session_id else null end) as mobile_session
from website_sessions
where created_at <= '2012-06-09'
and created_at >= '2012-04-15'
and utm_source = 'gsearch'
and utm_campaign = 'nonbrand'
group by week(created_at);
