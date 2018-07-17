#The purpose of this script is to grab tweets from Twitter, convert them into a data frame, and save them in a .txt file.
#The majority of this code is from the code demo for httr::oauth1-twitter.
#used the following handles c(elon = "elonmusk", nye = "BillNye", jt = "JustinTrudeau", colbert = "StephenAtHome", jengardy = "JenniferGardy", jenny = "JennyBryan", katy = "KatyPerry", daily = "TheDailyShow", jimmy = "JimmyFallon", trump = "realDonaldTrump")

library(twitteR)
library(httr)

# 1. Find OAuth settings for twitter:
oauth_endpoints("twitter")

# 2. Register an application at https://apps.twitter.com/
#    Make sure to set callback url to "http://127.0.0.1:1410/"
#
#    Replace key and secret below
myapp <- oauth_app("twitter",
                   key = "TYrWFPkFAkn4G5BbkWINYw",
                   secret = "qjOkmKYU9kWfUFWmekJuu5tztE9aEfLbt26WlhZL8"
)

# 3. Get OAuth credentials
twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)

# 4. Use API - now the code diverges from the demo
setup_twitter_oauth(consumer_key = twitter_token[["app"]][["key"]] , consumer_secret = twitter_token[["app"]][["secret"]], access_token = twitter_token[["credentials"]][["oauth_token"]], access_secret = twitter_token[["credentials"]][["oauth_token_secret"]] )

#3200 is the max number of tweets requestable
elon_tweets <- userTimeline("elonmusk", n = 3200)
elon_tweets_df <- tbl_df(map_df(elon_tweets, as.data.frame))

write.table(elon_tweets_df, "data/elon_tweets_df.txt", sep = "\t")

