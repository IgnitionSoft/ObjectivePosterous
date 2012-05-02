Pod::Spec.new do |s|
  s.name          = 'ObjectivePosterous'
  s.version       = '0.1.0'
  s.license       = 'MIT'
  s.summary       = 'Posterous API Client for Objective-C with minimal features, based on Posterous API v2'
  s.homepage      = 'https://github.com/IgnitionSoft/ObjectivePosterous'
  s.authors       = { 'Francis Chong' => 'francis@ignition.hk' }
  s.source        = { :git => 'git://github.com/IgnitionSoft/ObjectivePosterous.git', :tag => '0.1.0' }
  s.source_files  = 'ObjectivePosterous/Classes/*.{h,m}'
  s.clean_paths   = '*.xcodeproj', 'Pods', 'ObjectivePosterousSpec'
  s.requires_arc  = true

  s.dependency 'MKNetworkKit'
  s.dependency 'JTObjectMapping'
  s.dependency 'JSONKit'
end