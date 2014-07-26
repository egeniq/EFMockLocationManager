Pod::Spec.new do |s|
  s.name         = "EFMockLocationManager"
  s.version      = "0.1.0"
  s.summary      = "EFMockLocationManager is a drop-in replacement for CLLocationManager with a location simulator."
  s.description  = "EFMockLocationManager allows you to test location based apps by simulating predefined routes, similar to iOS Simulator's freeway drive simulator, but with a little more control of the locations."
  s.homepage     = "https://github.com/Egeniq/EFMockLocationManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ivo Jansch" => "ivo@egeniq.com" }
  s.platform     = :ios
  s.ios.deployment_target = "5.1.1"
  s.source       = { :git => "https://github.com/Egeniq/EFMockLocationManager.git", :tag => s.version.to_s }
  s.public_header_files = 'EFMockLocationManager/*.h'
  s.private_header_files = 'EFMockLocationManager/Internal/*.h'
  s.source_files = 'EFMockLocationManager/**/*.{h,m}'
  s.requires_arc = true
end
