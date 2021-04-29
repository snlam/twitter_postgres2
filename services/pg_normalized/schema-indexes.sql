create index idx_tweet_tags_id_tweets_tag_lang on tweet_tags (id_tweets,tag);

create index idx_tweets_id_tweets on tweets (id_tweets,lang);

create index idx_tweets_fts on tweets using gin(to_tsvector('english',text)) where lang = 'en';
