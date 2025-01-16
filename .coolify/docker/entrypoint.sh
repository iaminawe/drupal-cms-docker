#!/bin/sh
set -e

# Run composer install if vendor directory doesn't exist
if [ ! -d /opt/drupal/vendor ]; then
    echo "Running composer install..."
    cd /opt/drupal
    composer install --no-dev --optimize-autoloader
fi

# First arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- php-fpm "$@"
fi

# Start PHP-FPM
exec "$@"
