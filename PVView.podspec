#
#  Be sure to run `pod spec lint PVView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "PVView"
  s.version      = "1.0.2"
  s.summary      = "Easier way to build a parallax view"
  s.description  = <<-DESC
  A small lib that helps you to build amazing parallax views
                   DESC

  s.homepage     = "https://github.com/toannt/PVView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Toan Nguyen" => "toannt.ce@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/toannt/PVView.git", :tag => "#{s.version}" }
  s.source_files  = "PVView/**/*.swift"
  s.swift_version = "5.0"
end
