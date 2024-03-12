# Boston.local

This is an all-in-one localhost environment for boston.com. It has ElasticSearch, MariaDB, and Redis installed in their own containers.

## Getting Started

#### Prerequisites

* **Node.js**. You need version 12, and also a more up to date version such as 16.
* **NVM**. This is the easiest way install multiple Node versions, and to switch between versions.
* **Docker**. Docker is required to start the containers. 
* **Docker-Desktop**. *Optional*. This is a handy GUI that lets you see all your containers, and more importantly, access the log files in the containers.

#### Setup 

1. Clone this repo into your machine.
2. Create a folder wordpress in the root. This folder will be ignored by this repo.
3. Start the containers, using `docker-compose up`.
4. Use the WP-CLI to install the WordPress core into the wordpress folder.
5. Clone the BDC repo (https://github.com/BostonGlobe/wp-theme-bdc2) into the wordpress/wp-content folder, replacing all files.
6. Use the WordPress setup script to install the site as *boston.local*. This will distinguish it from localhost sites set up as boston.test, which is the 10updocker convention.

#### Configure WordPress

The following additions to the wp-config.php file are recommended:
`define( 'WP_REDIS_HOST', 'redis' );`
`define( 'WP_ELASTICSEARCH_HOST', 'elasticsearch' );`
`define( 'WP_ELASTICSEARCH_PORT', '9200' );`
`define( 'WP_DEBUG', true );`
`define( 'WP_DEBUG_LOG', true );`
`define( 'WP_DEBUG_DISPLAY', false );`
`define( 'SCRIPT_DEBUG', true );`


#### WP-CLI

The Docker Compose stack has WP-CLI built in. To execute commands you have to run them inside the container this way: `docker-compose exec wordpress wp db check`. 

It is possible to add a shorten the command by adding an alias to your machine. 
Edit your .zprofile (or .profile or .bash_profile, depending on your terminal set up). 
Add an alias this way: `alias docker-wp='docker-compose exec wordpress wp'`.

Now you can go into the folder with the Dockerfile and simply run `docker-wp db check`.

#### Install dependencies for the theme and plugin

Run these in the wordpress/wp-content folder:
`npm install`
`composer install`

Run in the wordpress/wp-content/plugins/bdc-functionality folder:
`npm install`
`composer install`

#### Build CSS and JS files in watch mode

To build and watch changes, go into wordpress/wp-content.
`nvm use 12`
`npm run watch`


#### Codesniffer for style consistency

Install PHP Codesniffer on your machine. This can be done as a Composer global dependency: 
`composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true`

Confirm that phpcs is available on the command line as `phpcs`. You can add Composer's bin folder to your PATH if it is not availabe.

Also using Composer, install the WordPress coding standard:
`composer global require --dev wp-coding-standards/wpcs:"^3.0"`

Then, clone the WordPress-BGMP standard, which is a subset of the WordPress-Core standard:
https://github.com/BostonGlobe/wp-bgmp-coding-standard.

The WP BGMP standard can be anywhere on your machine. Add the BGMP standard to the phpcs configuration like this:
`phpcs --config-set installed_paths /path/to/wp-bgmp-coding-standard`

Install a Codesniffer plugin in your code editor. PHP Sniffer by *wongin* works well in VS Code (3/2024). 

Now you should be able to set the coding standard in the Codesniffer plugin to **WordPress-BGMP**.
