Pod::Spec.new do |s|
  s.name        = 'RxOptional'
  s.version     = '3.6.2'
  s.summary     = 'RxSwift extensions for Swift optionals and Occupiable types'

  s.description = <<-DESC
                  RxSwift extensions for Swift optionals and "Occupiable" types.
                  DESC

  s.homepage    = 'https://github.com/RxSwiftCommunity/RxOptional'
  s.license     = 'MIT'
  s.author      = { 'RxSwift Community' => 'community@rxswift.org' }
  s.source      = {
                    :git => 'https://github.com/RxSwiftCommunity/RxOptional.git',
                    :tag => s.version.to_s
                  }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'Source/*.swift'

  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
  s.frameworks = 'Foundation'
end
