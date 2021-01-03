#!/usr/bin/env bash

set -euo pipefail
rm -rf xcarchives/*
rm -rf RxOptional.xcframework

xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional iOS" -sdk iphoneos -archivePath "xcarchives/RxOptional-iOS" clean
# xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional iOS" -sdk iphonesimulator  -archivePath "xcarchives/RxOptional-iOS-Simulator" 
xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional tvOS" -sdk appletvos -archivePath "xcarchives/RxOptional-tvOS" clean
# xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional tvOS" -sdk appletvsimulator -archivePath "xcarchives/RxOptional-tvOS-Simulator" 
xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional macOS" -sdk macosx -archivePath "xcarchives/RxOptional-macOS" clean
xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional watchOS" -sdk watchos -archivePath "xcarchives/RxOptional-watchOS" clean 
# xcodebuild archive -project RxOptional.xcodeproj -scheme "RxOptional watchOS" -sdk watchsimulator -archivePath "xcarchives/RxOptional-watchOS-Simulator" 

xcodebuild -create-xcframework \
-framework "xcarchives/RxOptional-iOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-iOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-tvOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-tvOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-macOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-macOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-watchOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-watchOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-output "RxOptional.xcframework" 

zip -r RxOptional.xcframework.zip RxOptional.xcframework
rm -rf xcarchives/*
rm -rf RxOptional.xcframework