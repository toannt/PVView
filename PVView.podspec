Pod::Spec.new do |s|
  s.name         	= "PVView"
  s.version      	= "1.0.4"
  s.summary      	= "Easier way to build a parallax view"
  s.description  	= <<-DESC
  PVView is a small library that helps you to make an amazing parallax view.
                   	DESC

  s.homepage     	= "https://github.com/toannt/PVView"
  s.license      	= { :type => "MIT", :file => "LICENSE" }
  s.author       	= { "Toan Nguyen" => "toannt.ce@gmail.com" }
  s.platform     	= :ios, "9.0"
  s.source       	= { :git => "https://github.com/toannt/PVView.git", :tag => "#{s.version}" }
  s.source_files 	= "PVView/**/*.swift"
  s.swift_version 	= "5.0"
end
