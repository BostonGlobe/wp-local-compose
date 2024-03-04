# Boston.local

This is an all-in-one localhost environment for boston.com.

## Getting Started

1. Clone this repo into your machine.
2. Use the WP-CLI to install the WordPress core into the wordpress folder.
3. Clone the BDC repo into the wordpress/wp-content folder, replacing all files.
4. 

### Prerequisites

What things you need to install the software and how to install them.
**Node.js**. You need version 12, and also a more up to date version such as 16.


### Config

The following additions to the wp-config.php file are recommended:

    define( 'WP_REDIS_HOST', 'redis' );
    define( 'WP_ELASTICSEARCH_HOST', 'elasticsearch' );
    define( 'WP_ELASTICSEARCH_PORT', '9200' );
	define( 'WP_DEBUG', true );

End with an example of getting some data out of the system or using it for a little demo.

### WP-CLI

The Docker Compose stack has WP-CLI built in. To execute commands you have to run them inside the container this way: `docker-compose exec wordpress wp db check`. 

It is possible to add a shorten the command by adding an alias to your machine. 
Edit your .zprofile (or .profile or .bash_profile, depending on your terminal set up). 
Add this line: `alias docker-wp='docker-compose exec wordpress wp'`.

Now you can go to the folder witht he Dockerfile and simply run `docker-wp db check`.

### Build the theme and plugin

Run these in the wordpress/wp-content folder. 
Also run these in the wordpress/wp-content/plugins/bdc-functionality folder.
`npm install`
`composer install`

The build and/or watch changes, go into wordpress/wp-content.
`nvm use 12`



### And coding style tests

The developer 
