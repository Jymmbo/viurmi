import twitter
import json

# aaaaaaaaaaaaaaimport polyglot

# aaaaaaaaaaaaaafrom polyglot.text import Text, Word

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

auth = twitter.oauth.OAuth(OAUTH_TOKEN, OAUTH_TOKEN_SECRET,
                           CONSUMER_KEY, CONSUMER_SECRET)

twitter_api = twitter.Twitter(auth=auth)

# Nothing to see by displaying twitter_api except that it's now a
# defined variable

print twitter_api

# Vamos a buscar los 10 mayores Trending Topics


# En un PRIMERO PASO: GET trends/place --> para obtener los 10 trending topics
# -El parametro WORLD_WOE_ID se corresponde con la ubicacion mundial. En nuestro caso, vamos a realizar la busqueda en todo el mundo, por ello =1
WORLD_WOE_ID = 1
world_trends = twitter_api.trends.place(_id=WORLD_WOE_ID)
# print world_trends
# Para mostrar los resultados en un formato Json
# print json.dumps(world_trends, indent=1)

# it's about time to create a TwitterSearch object with our secret tokens
ts = TwitterSearch(
	consumer_key = CONSUMER_KEY,
	consumer_secret = CONSUMER_SECRET,
	access_token = OAUTH_TOKEN,
	access_token_secret = OAUTH_TOKEN_SECRET
)

for trend in world_trends[0]['trends']:
#	print(trend['query'])
#	print(trend['name'])
#	ME SACA LOS MISMOS RESULTADOS CON AMBOS VALORES COMO FILTRO DE BUSQUEDA

# aaaaaaaaaaaaaaif(trend['name'].language.code = 'en'):
# aaaaaaaaaaaaaaLO HAGO TODO, SINO, TERMINO


# En un SEGUNDO PASO: buscamos Tweets en ingles para los Trending que asi lo sean
# lo hacemos con TwitterSearch

	tso = TwitterSearchOrder() # create a TwitterSearchOrder object
	tso.set_keywords([trend['name']]) # let's define all words we would like to have a look for
	tso.set_language('en') # we want to see German tweets only
	tso.set_include_entities(False) # and don't give us all those entity information
	print('###############################' + trend['name'] + '###############################')
	
	# this is where the fun actually starts :)
	for tweet in ts.search_tweets_iterable(tso):
		print( '@%s tweeted: %s' % ( tweet['user']['screen_name'], tweet['text'] ) )
		
	print('------------------------------------------------------------------------------------------')


# En un SEGUNDO PASO: GET search/tweets: a partir de los trending topics anteriores, realizamos la busqueda
# -Intentamos obtener 1.000 por cada. A VER QUE PASA CON LOS MIL!!
# -Parametros: q (identificador, obtenido del metodo anterior), locale (lengua), count (numero)
#	count = 5
#	locale = 'en'
#	lang = 'en'
#	search_results = twitter_api.search.tweets(q=trend['name'], count=count, locale=locale, lang=lang)
#	for tweet in search_results['statuses']:
#		user = tweet['user']['name']
#		text = tweet['text']
#		print('USUARIO:' + tweet['user']['name'] + ':TEXTO:' + tweet['text'])
#		print(tweet['user']['name'])
#
#	print('------------------------------------------------------------------------------------------')


####################################
# Como lo de la deteccion de idiomas no funciona, le metemos un LanguageDetection