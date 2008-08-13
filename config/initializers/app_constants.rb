# Be sure to restart your server when you modify this file.
# This file contains site-specific global constants used throughout the application.
# Constants can be changed here but it may be more convenient to set them in the
# file "config/config.yml" or "config/config.local.yml" where the app_config plugin
# does its magic (plugins are loaded before initializers). Values set in "config/config.yml" 
# are called in this file like this: "Conf.site_url."

SITE_URL = "#{Conf.site_url}".freeze
SITE_EMAIL_ADDRESS = "#{Conf.site_email_address}".freeze
SITE_NAME = "#{Conf.site_name}".freeze
ADMIN_LOGIN = "#{Conf.admin_login}".freeze
ADMIN_EMAIL_ADDRESS = "#{Conf.admin_email_address}".freeze
ADMIN_PASSWORD = "#{Conf.admin_password}".freeze
GOOGLE_ACCOUNT_LOGIN = "#{Conf.google_account_login}".freeze
GOOGLE_ACCOUNT_PASSWORD = "#{Conf.google_account_password}".freeze
