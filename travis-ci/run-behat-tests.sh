#!/usr/bin/env bash

echo "Running headless Behat tests..."
"${ROOT_DIR}"/backdrop/modules/"${MODULE_NAME}"/tests/behat/bin/behat --stop-on-failure --strict --config "${ROOT_DIR}"/backdrop/modules/"${MODULE_NAME}"/tests/behat/behat.travis.yml --verbose --tags "${HEADLESS_BEHAT_TAGS}"
earlyexit

#echo "Running JavaScript Behat tests..."
#"${ROOT_DIR}"/backdrop/modules/"${MODULE_NAME}"/tests/behat/bin/behat --stop-on-failure --strict --config "${ROOT_DIR}"/backdrop/modules/"${MODULE_NAME}"/tests/behat/behat.travis.yml --verbose --tags "${JS_BEHAT_TAGS}"
#earlyexit

exit 0
