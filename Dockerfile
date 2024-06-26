FROM wordpress:php8.3-fpm

# Install MySQL client
RUN apt-get update && \
    apt-get install -y default-mysql-client && \
    rm -rf /var/lib/apt/lists/*
	
# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --info
    
# Install Redis extension for PHP.
# This includes PhpRedis, which is necessary for the Object Cache Pro plugin.
RUN if ! pecl list | grep -q redis; then pecl install redis && docker-php-ext-enable redis; fi
