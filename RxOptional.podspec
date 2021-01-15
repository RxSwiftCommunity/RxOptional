Pod::Spec.new do |s|
  s.name = "RxOptional"
  # Version to always follow latest tag, with fallback to major
  s.version = "5.0.0"
  s.license = "MIT"
  s.summary = "RxSwift extensions for Swift optionals and Occupiable types"

  s.description = <<-DESC
                  RxSwift extensions for Swift optionals and "Occupiable" types.
                  DESC

  s.homepage = "https://github.com/RxSwiftCommunity/RxOptional"
  s.authors = { "RxSwift Community" => "community@rxswift.org" }
  s.source = { :git => "https://github.com/RxSwiftCommunity/RxOptional.git", :tag => "v" + s.version.to_s }
  s.swift_version = "5.1"

  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.10"
  s.watchos.deployment_target = "3.0"
  s.tvos.deployment_target = "10.0"

  s.requires_arc = true

  s.source_files = "Sources/RxOptional/*.swift"

  s.frameworks = "Foundation"
  s.dependency "RxSwift", "~> 6.0"
  s.dependency "RxCocoa", "~> 6.0"
end
