#!/usr/bin/env bash

set -euo pipefail
rm -rf RxOptional-SPM.xcodeproj
rm -rf xcarchives/*
rm -rf RxOptional.xcframework.zip
rm -rf RxOptional.xcframework

xcodegen --spec project-spm.yml

xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional iOS" -destination "generic/platform=iOS" -archivePath "xcarchives/RxOptional-iOS" SKIP_INSTALL=NO SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional iOS" -destination "generic/platform=iOS Simulator" -archivePath "xcarchives/RxOptional-iOS-Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional tvOS" -destination "generic/platform=tvOS" -archivePath "xcarchives/RxOptional-tvOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional tvOS" -destination "generic/platform=tvOS Simulator"  -archivePath "xcarchives/RxOptional-tvOS-Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional macOS" -destination "generic/platform=macOS" -archivePath "xcarchives/RxOptional-macOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional watchOS" -destination "generic/platform=watchOS" -archivePath "xcarchives/RxOptional-watchOS" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple
xcodebuild archive -quiet -project RxOptional-SPM.xcodeproj -configuration Release -scheme "RxOptional watchOS" -destination "generic/platform=watchOS Simulator" -archivePath "xcarchives/RxOptional-watchOS-Simulator" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES OTHER_CFLAGS="-fembed-bitcode" BITCODE_GENERATION_MODE="bitcode" ENABLE_BITCODE=YES | xcpretty --color --simple

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
rm -rf RxOptional-SPM.xcodeproj