/*
 * Calculates the languages that commonly use the hashtag #coronavirus
 */
select lang, count(distinct id) from (
	select
	data ->> 'lang' as lang, data -> 'id' as id from tweets_jsonb
	where (
		(((data->'extended_tweet'::text) -> 'entities'::text) -> 'hashtags'::text) @> '[{"text":"coronavirus"}]'
		OR
		((data->'entities'::text) -> 'hashtags'::text) @> '[{"text":"coronavirus"}]')
) as filler
group by (lang)
order by count desc, lang;
