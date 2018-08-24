#!/usr/bin/env bash

# Disable XDebug to speed up test runs.
phpenv config-rm xdebug.ini

# Add database and settings.php file.
mysql -e "CREATE DATABASE backdrop;"
mysql -e "CREATE USER 'backdrop'@'localhost' IDENTIFIED BY 'backdrop';"
mysql -e "GRANT ALL PRIVILEGES ON * . * TO 'backdrop'@'localhost';"
earlyexit
mysql -e "FLUSH PRIVILEGES;"

# Might want to copy a local settings file here...
#cp ${ROOT_DIR}/backdrop/modules/${MODULE_NAME}/tests/travis-ci/settings.travis.php ${ROOT_DIR}/drupal/sites/default/settings.php

# Disable sendmail from https://www.drupal.org/project/phpconfig/issues/1826652.
echo sendmail_path=`which true` >> ~/.phpenv/versions/$(phpenv version-name)/etc/php.ini

# Add PHP config that matches recommendation?
#phpenv config-add $ROOT_DIR/drupal/profiles/express/tests/travis-ci/config/express-php.ini
#earlyexit

# Change InnoDB settings that speed things up.
# https://www.percona.com/blog/2015/02/24/mysqls-innodb_file_per_table-slowing/.
mysql -e "SET @@global.innodb_file_per_table=0;"

# https://dba.stackexchange.com/questions/12611/is-it-safe-to-use-innodb-flush-log-at-trx-commit-2.
mysql -e "SET @@global.innodb_flush_log_at_trx_commit=2;"
earlyexit

# Echo out some system info.
#php -i | grep memory
#cat /proc/meminfo

exit 0
