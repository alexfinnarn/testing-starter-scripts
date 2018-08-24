#!/usr/bin/env bash

# Check for latest release of testing-starter-template and fail test if this is behind.

# Install latest Drush 8.
composer global require "drush/drush:8.*"
export PATH="$HOME/.composer/vendor/bin:$PATH"

mkdir -p ~/.drush/commands
cd ~/.drush/commands

# Need to use special runserver command branch.
git clone --branch alex-test https://github.com/alexfinnarn/drush.git backdrop

# Build Behat dependencies.
cp -R "${ROOT_DIR}"/testing/behat/* "${ROOT_DIR}"/"${MODULE_NAME}"/tests/behat
cd "${ROOT_DIR}"/"${MODULE_NAME}"/tests/behat
composer install --prefer-dist --no-interaction
earlyexit

# Build Codebase.
cd "${ROOT_DIR}"
echo "Cloning Backdrop repo..."
git clone --branch 1.x --depth 1 https://github.com/backdrop/backdrop.git "${ROOT_DIR}"/backdrop

echo "Copying your module into the modules directory..."
cp -R "${ROOT_DIR}"/"${MODULE_NAME}" "${ROOT_DIR}"/backdrop/modules

echo "Cloning down contrib modules..."
for i in $(echo "${ADD_CONTRIB_MODULES}" | sed "s/ / /g")
do
  git clone https://github.com/backdrop-contrib/"${i}".git "${ROOT_DIR}"/backdrop/modules/"${i}"
done

# Setup files? Does this need to happen in Backdrop?
#mkdir -p $ROOT_DIR/drupal/sites/default/files/styles/preview/public/gallery/ && chmod -R 777 $ROOT_DIR/drupal/sites
#mkdir $ROOT_DIR/tmp && chmod -R 777 $ROOT_DIR/tmp

exit 0
