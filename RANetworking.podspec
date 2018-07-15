#
# Be sure to run `pod lib lint RANetworking.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RANetworking'
  s.version          = '0.1.0'
  s.summary          = 'RANetworking is a light weight HTTP networking library written using Swift Protocols.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RANetworking is a light weight HTTP library written using Swift Protocols. It is written on top of URLSession. The library is 100% swift.

                            DESC

  s.homepage         = 'https://github.com/rizwan95/RANetworking'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Rizwan' => 'rizwan.ahmed95@gmail.com' }
  s.source           = { :git => 'https://github.com/Rizwan/RANetworking.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rizwanasifahmed'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RANetworking/Classes/**/*'
  
  s.swift_version = '4.0'
  
  # s.resource_bundles = {
  #   'RANetworking' => ['RANetworking/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
