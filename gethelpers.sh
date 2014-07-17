#!/bin/bash

WAIT_FOR_EMULATOR_URL=https://github.com/embarkmobile/android-sdk-installer/raw/version-2/wait_for_emulator
ACCEPT_LICENSES_URL=https://github.com/embarkmobile/android-sdk-installer/raw/version-2/accept-licenses

curl -3L -o wait_for_emulator $WAIT_FOR_EMULATOR_URL
chmod +x wait_for_emulator
curl -3L -o accept-licenses $ACCEPT_LICENSES_URL
chmod +x accept-licenses
