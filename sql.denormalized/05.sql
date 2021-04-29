/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
select '#' || tags as tag,
count(distinct id) from
      (
	select
	jsonb_array_elements(coalesce((data->'extended_tweet'::text -> 'entities'::
	text -> 'hashtags'::text), (data->'entities'::text -> 'hashtags'::text )))->>'text'
	as tags, data->'id' as id
	from tweets_jsonb
	where
	data->>'lang' = 'en' AND
	to_tsvector('english', coalesce((data->'extended_tweet' ->> 'full_text'),
	   (data->>'text'))) @@ to_tsquery('english', 'coronavirus')
      ) as filler
group by (1)
order by count desc, tag
limit 1000;
