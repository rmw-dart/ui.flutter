#!/usr/bin/env bash

set -ex

adb connect 172.16.0.45:38055

adb devices -l

flutter devices
