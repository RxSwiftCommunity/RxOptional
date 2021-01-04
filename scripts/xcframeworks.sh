#!/usr/bin/env bash

set -euo pipefail
rm -rf xcarchives/*
rm -rf RxOptional.xcframework.zip

xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional iOS" -sdk iphoneos -archivePath "xcarchives/RxOptional-iOS"
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional iOS" -sdk iphonesimulator  -archivePath "xcarchives/RxOptional-iOS-Simulator"
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional tvOS" -sdk appletvos -archivePath "xcarchives/RxOptional-tvOS"
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional tvOS" -sdk appletvsimulator -archivePath "xcarchives/RxOptional-tvOS-Simulator"
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional macOS" -sdk macosx -archivePath "xcarchives/RxOptional-macOS"
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional watchOS" -sdk watchos -archivePath "xcarchives/RxOptional-watchOS"
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -scheme "RxOptional watchOS" -sdk watchsimulator -archivePath "xcarchives/RxOptional-watchOS-Simulator"

xcodebuild -create-xcframework \
-framework "xcarchives/RxOptional-iOS-Simulator.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-iOS-Simulator.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-iOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-iOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-tvOS-Simulator.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-tvOS-Simulator.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-tvOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-tvOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-macOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-macOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-watchOS-Simulator.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-watchOS-Simulator.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-framework "xcarchives/RxOptional-watchOS.xcarchive/Products/Library/Frameworks/RxOptional.framework" \
-debug-symbols ""$(pwd)"/xcarchives/RxOptional-watchOS.xcarchive/dSYMs/RxOptional.framework.dSYM" \
-output "RxOptional.xcframework" 

zip -r RxOptional.xcframework.zip RxOptional.xcframework
rm -rf xcarchives/*
rm -rf RxOptional.xcframework