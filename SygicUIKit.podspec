#
# Be sure to run `pod lib lint SygicUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SygicUIKit'
  s.version          = '0.1.0'
  s.summary          = 'Kit of UI components made by Sygic.'
  s.swift_version = '4.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Sygic/sygic-ui-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sygic' => 'info@sygic.com' }
  s.source           = { :git => 'https://github.com/Sygic/sygic-ui-kit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SygicUIKit/Classes/**/*'
  s.resources = 'SygicUIKit/Resources/**/*.{xib,svg,jpg,png}'
  s.frameworks = 'UIKit'
  s.resource_bundle = {
	'SygicUIKit' => ['SygicUIKit/Resources/**/*.{ttf}'],
    'SygicUIKitStrings' => ['SygicUIKit/Resources/Langs/*.lproj/*.strings']
  }

  s.dependency 'GradientView'
  
end
