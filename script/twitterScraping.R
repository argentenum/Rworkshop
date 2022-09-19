#https://github.com/stevesteve2/TwitterWorkshop/blob/main/TwitterClass.R
#https://docs.ropensci.org/rtweet/
#https://developer.twitter.com/en/docs/twitter-api/getting-started/getting-access-to-the-twitter-api
#https://github.com/cjbarrie/academictwitteR
library(rtweet)
create_token(
  app = "appName",
  consumer_key = "APIkey",
  consumer_secret = "API Secret",
  access_token = "Access Token",
  access_secret = "Access Secret",
  set_renv = TRUE
)
rt <- search_tweets("#AsiaCup2022Final", n = 1000, include_rts = FALSE)
rt <- search_tweets("#AsiaCup2022Final", n = Inf, include_rts = FALSE, retryonratelimit = TRUE)
#rate limit 18000 tweets in 15 mins
#get user ids of those followed by an account
RfriendsID <- get_friends("iitdelhi")
#get details of those accounts
Rfriends <- lookup_users(RfriendsID$to_id)
#get details of followers of an account
RfollowersID <- get_followers("iitdelhi", n = 1000)
RfollowersID <- get_followers("iitdelhi", n = Inf, retryonratelimit = TRUE)
Rfollowers <- lookup_users(RfollowersID$from_id, retryonratelimit = TRUE)
#get tweet stream of an user
Rtimeline <- get_timeline("iitdelhi", n = 100)
#get favourites of a user
Rfav <- get_favorites("iitdelhi", n=100)
#get retweets of a particular tweet (by status id)
Rretweets <- get_retweets(timeline$id_str[1], n = 100)
#get trends at a particular location
#find woeid of the location
woeid <- trends_available()
Rtrends <- get_trends("Kolkata")
#get all tweets of a thread
Rthread <- tweet_threading("1562830167227002880", traverse = c("forwards"), verbose = TRUE)
#PART TWO
#academic twitter
library(tidyverse)
library(academictwitteR)
#set_bearer()
#get_bearer()

tweets <-
  get_all_tweets(
    query = "happy",
    start_tweets = "2022-08-09T10:00:00Z",
    end_tweets = "2022-08-10T10:00:00Z",
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