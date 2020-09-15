-- get count of unique sessions by traffic source

select utm_content, count(distinct website_session_id) as sessions
from website_sessions
where user_id between 1000 and 2000
group by
utm_content
order by count(distinct website_session_id) desc;

--
