import twitter

# XXX: Go to http://dev.twitter.com/apps/new to create an app and get values
# for these credentials, which you'll need to provide in place of these
# empty string values that are defined as placeholders.
# See https://dev.twitter.com/docs/auth/oauth for more information 
# on Twitter's OAuth implementation.

CONSUMER_KEY = ''
CONSUMER_SECRET = ''
OAUTH_TOKEN = ''
OAUTH_TOKEN_SECRET = ''

auth = twitter.oauth.OAuth(OAUTH_TOKEN, OAUTH_TOKEN_SECRET,
                           CONSUMER_KEY, CONSUMER_SECRET)

twitter_api = twitter.Twitter(auth=auth)

# Nothing to see by displaying twitter_api except that it's now a
# defined variable


# Vamos a buscar los 45 mayores Trending Topics y los vamos a escribir en un fichero txt

# GET trends/place --> para obtener los 50 trending topics
# -El parametro WORLD_WOE_ID se corresponde con la ubicacion mundial.
#	En nuestro caso, vamos a realizar la busqueda en todo el mundo, por ello =1

WORLD_WOE_ID = 1
world_trends = twitter_api.trends.place(_id=WORLD_WOE_ID)

keywordstxt = open ( 'files/allkeywords.txt', 'w' )

for trend in world_trends[0]['trends']:
	# print(trend['query'])
	# La query seria el elemento de busque da para hacer el search
	texto = trend['name'] + '\n'
	texto = texto.encode('utf-8')
	keywordstxt.write(texto)

####################################