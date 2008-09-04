# origin restful authentication

Use this example Rails application as a basis for a typical web application.

It provides a complete system for managing users, including sign up and verification of a new user's email address, login with role-based access control, and a system of resetting forgotten passwords, all using a RESTful architecture, as 
described in the forum discussion [Restful Authentication With All the Bells and Whistles](http://www.railsforum.com/viewtopic.php?id=14216).

The application provides _authentication_ (the user must enter a name and password to use the application) and _authorization_ (access to some pages is limited to users with an "administrator" role). To use the application, a visitor must sign up and click an activation link in an email message. If the user forgets his or her password, there is a forgot password option that emails a reset password link.

### Features from "Restful Authentication With All the Bells and Whistles"

* visitors register ("sign up") to create a user account
* new users are emailed a link to verify their email address and activate their account
* users "log in" to use the application by providing a username and password
* a "forgotten password" feature sets a new password for a user
* some users can be assigned an administrator role to edit or delete other users
* user management and authentication is implemented with a RESTful architecture

### Added Features

* user status managed with the "acts as state machine" (AASM) plugin
* Email messages can be sent using a Google gmail account
* Application global configuration file
* RSpec stories and examples

The application does not provide support for the OpenID protocol. The forum discussion [Restful Authentication With All the Bells and Whistles](http://www.railsforum.com/viewtopic.php?id=14216) provides instructions for adding OpenID support if you require it.

## More Information

You can ask questions, make suggestions, and report problems:

* [Get Satisfaction for the RESTful Authentication Example Application](http://getsatisfaction.com/origin/products/origin_restful_authentication_example_application)

You can see the original announcement:

* [Rails RESTful Authentication Example Application](http://originblog.wordpress.com/2008/08/13/rails-restful-authentication-example-application/)

and keep up with developments on the blog:

* [Origin: Rails Example Applications](http://originblog.wordpress.com/)

## Dependencies

* Runs under Rails 2.1

## Rails Plugins Used

* restful\_authentication
* acts\_as\_state\_machine
* rspec
* rspec-rails
* app\_config

## Get It

The source code is managed with Git (a version control system) and hosted at GitHub. You'll need Git on your machine (install it from [http://git.or.cz/](http://git.or.cz/)).

You can download the app ("clone the repository") with the command

	$ git clone git://github.com/fortuity/origin_restful_authentication.git

## Configure Email

The application has been configured to use a Google gmail account to send confirmation emails to new users. Using a Google gmail account means you can host the application with a hosting provider who does not provide email services.

Configure email by modifying

	config/config.yml (or create "config/config.local.yml")
	
Alternatively, if you have an email server for your domain, you can use your own email server by modifying

	config/initializers/mail.rb
		
## Set Up the Database

You'll need to be in the application root directory:
    
	$ cd origin_restful_authentication

You can use the default settings if you're using SQLite. 

	$ cp config/database.sample.yml config/database.yml

If you're using MySQL, you'll need to edit the file

	config/database.yml

Running the database migrations sets up a user named "admin" with a password "admin" and a role of "administrator". You can modify the file

	config/config.yml

if you wish to change the administrator name and password before you run the migration.
	
Set up the database by running

	$ rake db:create:all
	$ rake db:migrate

If you get an error

	SQLite3::SQLException: no such table
	
it means you didn't run the database migration.
	
## Getting Started

Start the server

	$ script/server

and go to http://localhost:3000/. 

To sign in as the pre-configured admin user, (unless you've changed it) use

		name: admin
		password: admin

You should change the admin user name and password after you log in.

## Deploy

Before you deploy to production, be sure to replace example values such as http://www.mydomain.com/ with your site information in the file:

	config/config.yml
	
For full security, change the REST\_AUTH\_SITE\_KEY in 

	config/initializers/site_keys.rb

## Running RSpec

RSpec is a framework for creating specifications and testing a Rails web application. 

You can run RSpec "stories" to see the specifications for the application's behavior. You can run RSpec "examples" to verify the application is behaving as intended at the object level.

You must prepare the test database before running RSpec:

	$ rake db:test:prepare
	
which takes a schema dump from the development database and uses it to create a test database. (If you're modifying the app, you'll need to do that after every migration.)

Be sure that you've prepared the app to send email:

* set your gmail login and password in config/config.yml
* or modify config/initializers/mail.rb
	
or you will get many failures when you run RSpec.

To see the RSpec stories:

	$ ruby stories/all.rb

To run the RSpec examples:

	$ rake spec

When you run RSpec stories or examples, real email messages are sent. You may get "mail undelivered" bounce messages unless you change email addresses throughout the RSpec code. Search and replace for "rspectest.com" if the bounce messages irritate you.
	
## To Do

* Add RSpec examples and stories to cover more "Bells and Whistles" features
* Change "login" to use email addresses instead

## Done

* Created an empty default Rails app
* Added a License and README file
* Created a .gitignore file
* Checked the app into GitHub
* Added RSpec (version 1.1.4)
* Installed the restful_authentication plugin (version of 08/07/08)
* Installed the "acts as state machine" plugin (version 2.1)
* Tagged step-1
* Ran the restful_authentication generator ("./script/generate authenticated user sessions --stateful --rspec")
* modified config/routes.rb and config/environment.rb as required
* Tagged step-2
* Added recommended "Bells and Whistles" features 
	* Created the model, controller, and views for resource "Roles"
	* Created a join model "Permission"
	* Created controller for "Passwords"
	* Created required migrations
	* Modified models "Role", "Permission", and "User"
	* Modified UserMailer and UserObserver
	* Added Google gmail support with lib/smtp\_tls.rb
	* Modified config/initializers/mail.rb
	* Modified lib/authenticated\_system.rb
	* Modified controllers
	* Added views
* Tagged step-3
* Added Eugene Bolshakov's AppConfig plugin
* Added Blueprint CSS framework
* Modified views and added CSS to apply design elements
* Tagged step-4
* Set up global constants in config/initializers/app\_constants_.rb
* Added a welcome page

## Documentation and Support

The forum discussion [Restful Authentication With All the Bells and Whistles](http://www.railsforum.com/viewtopic.php?id=14216) provides detailed information about the code. You can seek clarification or help there.

Here's another place to ask questions, make suggestions, and report problems:

* [Get Satisfaction for the RESTful Authentication Example Application](http://getsatisfaction.com/origin/products/origin_restful_authentication_example_application)

Here are useful blog postings:

* [How to Install RESTful Authentication on a Ruby on Rails 2.1 Application](http://crazyrails.com/how-to-install-restful-authentication/).
* Frank Lakatos's [How to Set Up Restful Authentication and acts_as_state_machine With Rails 2.1](http://fakingfantastic.com/2008/08/05/how-to-set-up-restful-authentication-and-acts_as_state_machine-with-rails-21/).
* Dan Engle's [My Take on Enhancing restful_authentication](http://morebs.com/2008/02/20/my-take-on-restful_authentication/).

This application is provided without additional documentation or support.

## Credits

* Rick Olson (and contributors) for the Restful Authentication Generator plugin
* "activefx" for "Restful Authentication With All the Bells and Whistles"
* Scott Barron for the "acts as state machine" plugin
* Graphic design derived from [Bruno Bornsztein's CommunityEngine](http://www.missingmethod.com/)
	
## License

### Public Domain Dedication

This work is a compilation and derivation from other previously released works. With the exception of various included works, which may be restricted by other licenses, the author or authors of this code dedicate any and all copyright interest in this code to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this code under copyright law. 
