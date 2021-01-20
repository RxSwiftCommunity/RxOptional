# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## 5.0.0 (2021-01-20)


### ⚠ BREAKING CHANGES

* - Moved circleci to githubci
- Supports RxSwift 6.0
- Release xcframeworks

### Features

* Restructure for better support and maintenance ([64eea0c](https://github.com/RxSwiftCommunity/RxOptional/commits/64eea0c51152d1dc89c076a6df133e2b0191f37b))


### Bug Fixes

* Actions to resolve dependencies before running ([f04fd38](https://github.com/RxSwiftCommunity/RxOptional/commits/f04fd38f67c529ab70da0e3802898e833129aaec))
* Bump version script ([a7a1c20](https://github.com/RxSwiftCommunity/RxOptional/commits/a7a1c20ec46104b10c8bd45767dc326b4a0b3405))
* Commit podspec version bump ([141cc95](https://github.com/RxSwiftCommunity/RxOptional/commits/141cc95fcebc5707c81419849b9c88cfb059aa4c))
* Reenable cleanup script ([c6c73f5](https://github.com/RxSwiftCommunity/RxOptional/commits/c6c73f53280c1f20d7a8415482f6de0d42fe2112))
* Remove unused step in action ([8566368](https://github.com/RxSwiftCommunity/RxOptional/commits/8566368791b701ce309249c9167011261a188558))

# 4.1.0

- Add suport for Swift Package Manager

# 4.0.0

- Requires RxSwift 5 & Xcode 10.2.
- Minimum iOS deployment target is iOS 9.
- Update WatchOS deployment target to 3.0.

# 3.6.2

- Updates RxSwift version.

# 3.6.0

- Updated for Swift 4.2 and Xcode 10.

# 3.5.0

- Loosen generic constraints to work with any SharingStrategy, instead of just Driver.

# 3.4.0

- Swift 4.1 compatibility

# 3.3.0

- Upgrades to RxSwift 4.0.

# 3.2.0

- Adds `filterNilKeepOptional`.

# 3.1.3

- RxSwift 3.0.0 support for Carthage.

# 3.1.2

- RxSwift 3.0.0-rc.1 support for Carthage.

# 3.1.1

- Improved Carthage support.

# 3.1.0

- Migrated Driver extensions into SharedSequenceConvertibleType

# 3.0.0

- Swift 3 compatibility

# 2.1.0

- Add `distinctUntilChanged` operator

# 2.0.0

- **Breaking Change**: Remove `fatalErrorOn*` operators
- **Breaking Change**: Remove guarantees from `catchOnEmpty` operators

# 1.2.0

- Add unit tests
- Move to RxSwiftCommunity
- Deprecate 'fatalErrorOn*' operators

# 1.1.0

- During release builds `fatalError` are logged
- Use guards

# 1.0.0

- First public release
- Add all documentation

# 0.1.1

- Initial release
