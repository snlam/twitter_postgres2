/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
select '#' || tags AS tag, count(distinct id) from
      (
	select
	jsonb_array_elements(coalesce((((data->'extended_tweet'::text) -> 'entities'::
	text) -> 'hashtags'::text), ((data->'entities'::text) -> 'hashtags'::text)))->>'text' as tags,
	data->'id' as id
	from tweets_jsonb
	where
	(data->'extended_tweet'::text -> 'entities'::text -> 'hashtags'::text) @>
	'[{"text":"coronavirus"}]' OR
	(data->'entities'::text -> 'hashtags'::text) @> '[{"text":"coronavirus"}]'
      ) as filler
group by (1)
order by count desc, tag
limit 1000;
