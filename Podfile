source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

# Add Application pods here
target :app do
  link_with 'bff.fm'
  pod 'AFNetworking', '~> 2.4.1'
  pod 'SDWebImage'
end

target :unit_tests, :exclusive => true do
  link_with 'UnitTests'
  pod 'Specta'
#, :git => 'https://github.com/specta/specta.git', :tag => 'v0.3.0.beta1'
  pod 'Expecta'
#, '~> 0.3.1'
  pod 'OCMock'
#, '~> 2.2.1' 
  pod 'OHHTTPStubs'
end
