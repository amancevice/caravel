import os

#---------------------------------------------------------
# Caravel specifix config
#---------------------------------------------------------
ROW_LIMIT = int(os.getenv('ROW_LIMIT', '5000'))
WEBSERVER_THREADS = int(os.getenv('WEBSERVER_THREADS', '8'))

CARAVEL_WEBSERVER_PORT = int(os.getenv('CARAVEL_WEBSERVER_PORT', '8088'))
#---------------------------------------------------------

#---------------------------------------------------------
# Flask App Builder configuration
#---------------------------------------------------------
# Your App secret key
SECRET_KEY = os.getenv('SECRET_KEY', '\2\1thisismyscretkey\1\2\e\y\y\h')

# The SQLAlchemy connection string.
SQLALCHEMY_DATABASE_URI = os.getenv('SQLALCHEMY_DATABASE_URI', 'sqlite:////caravel/caravel.db')

# Flask-WTF flag for CSRF
CSRF_ENABLED = os.getenv('CSRF_ENABLED', '1') in ('True', 'true', '1', 1)

# Whether to run the web server in debug mode or not
DEBUG = os.getenv('DEBUG', '1') in ('True', 'true', '1', 1)
