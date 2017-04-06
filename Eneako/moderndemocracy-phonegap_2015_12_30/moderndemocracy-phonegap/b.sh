#!/bin/bash
adb uninstall com.moderndemocracy.app
# cordova build android -- --ant --release
# adb install /Users/tomislav/workspace/moderndemocracy/moderndemocracy-phonegap/platforms/android/bin/MainActivity-release.apk
cordova build android --release
adb install /Users/tomislav/workspace/moderndemocracy/moderndemocracy-phonegap/platforms/android/build/outputs/apk/android-release.apk