from TwitterSearch import *

# XXX: Go to http://dev.twitter.com/apps/new to create an app and get values
# for these credentials, which you'll need to provide in place of these
# empty string values that are defined as placeholders.
# See https://dev.twitter.com/docs/auth/oauth for more information 
# on Twitter's OAuth implementation.

CONSUMER_KEY = ''
CONSUMER_SECRET = ''
OAUTH_TOKEN = ''
OAUTH_TOKEN_SECRET = ''

ts = TwitterSearch(
	consumer_key = CONSUMER_KEY,
	consumer_secret = CONSUMER_SECRET,
	access_token = OAUTH_TOKEN,
	access_token_secret = OAUTH_TOKEN_SECRET
)

# Leemos el fichero donte tenemos todas las keywords que utilizaremos en las busquedas

allkeywordstxt = open ( 'files/allkeywordfiltrado.txt' )
allkeywords = allkeywordstxt.readlines()

tweetsbusqueda = open ( 'files/todoslostweets.txt', 'w' )

# Empezamoa a realizar una busqueda por cada keyword

for keyword in allkeywords:
	
	# Le quitamos el salto de linea del final al keyword
	keyword = keyword [ :-1 ]
	
	# Creamos el objeto de busqueda	
	tso = TwitterSearchOrder()
	tso.set_language('en')
	tso.set_keywords([keyword])
	
	# Realizamos la busqueda con el keyword, para luego trata los 100 primeros tweets
	x=1
	for tweet in ts.search_tweets_iterable(tso):
		texto = tweet['user']['screen_name'] + ':' + tweet['text'] + '\n'
		texto = texto.encode('utf-8')
		tweetsbusqueda.write(texto)
		x += 1
		if(x>100):
			break

####################################