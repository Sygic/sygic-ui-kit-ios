#
# Be sure to run `pod lib lint SygicUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SygicUIKit'
  s.version          = '2.0.0'
  s.summary          = 'UI components used by SygicMapsKit'
  s.swift_version    = '4.2'

  s.description      = <<-DESC
  An open-source library containing UI components. Components are used in SygicMapsKit for UI. To get familiar with all the UI components available, you can first try out our sample application. To run the application, clone the repo, and run pod install from the Example directory first. Open SygicUIKit.xcworkspace and build.
                       DESC

  s.homepage         = 'https://github.com/Sygic/sygic-ui-kit-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sygic' => 'info@sygic.com' }
  s.source           = { :git => 'https://github.com/Sygic/sygic-ui-kit-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'SygicUIKit/Classes/**/*'
  s.resources = 'SygicUIKit/Resources/**/*.{xib,svg,jpg,png}'
  s.frameworks = 'UIKit'
  s.resource_bundle = {
      'SygicUIKit' => ['SygicUIKit/Resources/**/*.{ttf}'],
      'SygicUIKitStrings' => ['SygicUIKit/Resources/Langs/*.lproj/*.strings']
  }

  s.dependency 'GradientView'
  
end
