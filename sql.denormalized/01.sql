/*
 * Count the number of tweets that use #coronavirus
 */

select count(distinct data -> 'id') from tweets_jsonb
where ((data -> 'entities'::text) -> 'hashtags'::text) @> '[{"text":"coronavirus"}]' OR ((data -> 'extended_tweet'::text -> 'entities'::text) -> 'hashtags'::text) @> '[{"text":"coronavirus"}]';
