#https://github.com/stevesteve2/TwitterWorkshop/blob/main/TwitterClass.R
#https://github.com/cjbarrie/academictwitteR
library(rtweet)
library(tidyverse)
library(academictwitteR)
#set_bearer()
#get_bearer()
create_token(
  app = "Rjuntwitter",
  consumer_key = "GIEBH97DmbpP0l8ene33wyj99",
  consumer_secret = "kgimR8ZZriBAzZ69j4BE9CYmTYy392351rz0T9ldCOtzBRfC3y",
  access_token = "56965010-tsiv5Q4gm1D3k7XTPMF4PIr7zYSqmLKmLSw47dq6n",
  access_secret = "aQEk9LrPwouRxc4RBumMUrzRbRtgSgoZ5OOv6Cq6wgndb",
  set_renv = TRUE
)

tweets <-
  get_all_tweets(
    query = "happy",
    start_tweets = "2022-08-28T10:00:00Z",
    end_tweets = "2022-08-29T10:00:00Z",
    n = 100
  )

steverathje2 <- get_timeline("sachin_rt", n = 200)

#### Get Recent Tweets ####

tweets <- search_tweets("steve OR bob", n = 100, include_rts = FALSE, geocode = lookup_coords("usa"))

#right-leaning low quality news sites 
infowars <- search_tweets("infowars.com*", n = 3200)

#### Academic API #### 

#View documentation here: https://github.com/cjbarrie/academictwitteR

acadTweets <-
  get_all_tweets(
    query = "#fakenews",
    start_tweets = "2020-01-01T00:00:00Z",
    end_tweets = "2020-01-05T00:00:00Z",
    file = "fakenews",
    n = 100
  )

#### Other rtweet tricks ####

network <- get_friends("arjun_ghosh")
followers <- get_followers("arjun_ghosh")
users <- lookup_users(network$to_id)
users <- lookup_users(network$screen_name)