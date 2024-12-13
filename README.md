# Boston.local

This is an all-in-one localhost environment for boston.com. It has ElasticSearch, MariaDB, and Redis installed in their own containers. It will create self-signed certificates for the local URL, and install WP-CLI with access to the WP instance and Maria database containers.

## Getting Started

#### Prerequisites

* **Node.js**. You need version 12, and also a more up to date version such as 16.
* **NVM**. This is the easiest way install multiple Node versions, and to switch between versions.
* **Docker**. Required to build and start the containers. 
* **Docker-Desktop**. *Optional*. This is a handy GUI that lets you see all your containers, and access the containers' log files.

#### Setup 

1. Clone this repo into your machine.
2. Start the containers, using `docker compose up` (if you have an older version of Docker you might need `docker-compose`). A "certs" folder will be created for the self-signed certificates. This folder is also ignored by Git.
3. Add boston.local to your machine's host file. On a Mac, this is at /etc/hosts. You just need this line: `127.0.0.1 boston.local`.
4. Clone the BDC repo (https://github.com/BostonGlobe/wp-theme-bdc2) into the wordpress/wp-content folder, replacing all files.
5. Navigate to https://boston.local. Your browser might give you a security error, because it doesn't like the self signed certificate, but proceed as "unsafe". Your should see the WP database setup screen. Go ahead and set it up, as boston.local.

#### Configure WordPress

The following additions to the wp-config.php file are recommended. These allow the WP instance to use the Redis and ElasticSearch containers.
```
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_ELASTICSEARCH_HOST', 'elasticsearch' );
define( 'WP_ELASTICSEARCH_PORT', '9200' );
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
define( 'WP_DEBUG_DISPLAY', false );
define( 'SCRIPT_DEBUG', true );
```

#### WP-CLI

The Docker Compose stack has WP-CLI built in. To execute commands you have to run them inside the container this way: `docker compose exec wordpress wp db check`. 

It is possible to add a shorten the command by adding an alias to your machine. 
Edit your .zprofile (or .profile or .bash_profile, depending on your terminal set up). 
Add an alias this way: `alias docker-wp='docker compose exec wordpress wp'`.

Now you can go into the folder with the Dockerfile and simply run `docker-wp db check`.

#### Install dependencies for the theme and plugin

Run these in the wordpress/wp-content folder:

```
npm install
composer install
```
Also run in the wordpress/wp-content/plugins/bdc-functionality folder:
```
npm install
composer install
```
#### Build CSS and JS files in watch mode

To build and watch changes, go into wordpress/wp-content.
```
nvm use 12 // change to Node 12 to run watch.
npm run watch
```

#### Use Codesniffer for style consistency

1. Install PHP Codesniffer on your machine. This can be done as a Composer global dependency: 
`composer global config allow-plugins.dealerdirect/phpcodesniffer-composer-installer true`

2. Confirm that phpcs is available on the command line as `phpcs`. You can add Composer's bin folder to your PATH if it is not availabe.

3. Also using Composer, install the WordPress coding standard:
`composer global require --dev wp-coding-standards/wpcs:"^3.0"`

4. Then, clone the WordPress-BGMP standard, which is a subset of the WordPress-Core standard:
https://github.com/BostonGlobe/wp-bgmp-coding-standard.

5. The WP BGMP standard can be anywhere on your machine. Add the BGMP standard to the phpcs configuration like this:
`phpcs --config-set installed_paths /path/to/wp-bgmp-coding-standard`

6. Install a Codesniffer plugin in your code editor. PHP Sniffer by *wongin* works well in VS Code (3/2024). 

Now you should be able to set the coding standard in the Codesniffer plugin to "WordPress-BGMP". 
