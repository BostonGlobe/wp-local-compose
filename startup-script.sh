#!/bin/bash
# Replace placeholders with environment variable values
envsubst < /usr/local/apache2/conf/apache-config.conf > /usr/local/apache2/conf/apache-config.conf.tmp
mv /usr/local/apache2/conf/apache-config.conf.tmp /usr/local/apache2/conf/apache-config.conf

# Start Apache in the foreground
httpd-foreground
