#!/usr/bin/env bash

set -ex

adb connect 172.16.0.45:42327

adb devices -l

flutter devices
