#!/usr/bin/env bash

# Install a site.
cd "${ROOT_DIR}"/backdrop
"${HOME}"/.composer/vendor/bin/drush si --db-url=mysql://backdrop:backdrop@127.0.0.1/backdrop -y
earlyexit

# Enable any additional modules used during test runs.
echo "Enabling additional testing modules..."

echo "Enabling contrib modules..."
"{$HOME}"/.composer/vendor/bin/drush en "${ADD_CONTRIB_MODULES}" -y
earlyexit

echo "Enabling custom modules..."
"${HOME}"/.composer/vendor/bin/drush en "${ADD_CUSTOM_MODULES}" -y
"${HOME}"/.composer/vendor/bin/drush cc all
earlyexit

# Enable module.
echo "Enabling project module..."
cd "${ROOT_DIR}"/backdrop
"${HOME}"/.composer/vendor/bin/drush en "${MODULE_NAME}" -y
earlyexit

# Run any database updates.
echo "Running pending database updates..."
"${HOME}"/.composer/vendor/bin/drush updb -y
earlyexit

# Start server.
cd "${ROOT_DIR}"/backdrop
"${HOME}"/.composer/vendor/bin/drush backdrop-runserver 127.0.0.1:8057 > /dev/null 2>&1 &
nc -zvv 127.0.0.1 8057; out=$?; while [[ $out -ne 0 ]]; do echo "Retry hit port 8057..."; nc -zvv localhost 8057; out=$?; sleep 5; done
earlyexit

exit 0
