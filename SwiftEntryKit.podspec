#
# Be sure to run `pod lib lint SwiftEntryKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = 'SwiftEntryKit'
  s.version = '0.1.1'
  s.summary = 'Present notification entries inside your App'
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.requires_arc = true

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description = 'SwiftEntryKit offers you a simple way to present notification entries or popups inside your iOS application.'

  s.homepage         = 'https://github.com/huri000/SwiftEntryKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Daniel Huri' => 'huri000@gmail.com' }
  s.source           = { :git => 'https://github.com/huri000/SwiftEntryKit.git', :tag => s.version.to_s }

  s.source_files = 'SwiftEntryKit/**/*'
  
  # s.resource_bundles = {
  #   'SwiftEntryKit' => ['SwiftEntryKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'QuickLayout', '1.0.11'
  
  # s.dependency 'Quick', '1.2.0'
  # s.dependency 'Nimble', '7.0.2'
end
