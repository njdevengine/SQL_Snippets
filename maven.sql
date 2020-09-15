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
