from .settings import *

ALLOWED_HOSTS = ['theavid.dev', 'www.theavid.dev']

SECRET_KEY = 'GOOD SECRET KEY HERE'

DEBUG = False

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'sitedb',
        'USER': 'sitedbuser',
        'PASSWORD': 'YOUR POSTGRES PASSWORD',
        'HOST': 'sitedb',
        'PORT': '5432',
    }
}

STATIC_URL = '/static/'
STATIC_ROOT = '/site/static'

MEDIA_URL = '/media/'
MEDIA_ROOT = '/site/media'
