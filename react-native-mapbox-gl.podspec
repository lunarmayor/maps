require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

default_ios_mapbox_version = '~> 10.0.0-beta.13'

rnmbgl_ios_version = $ReactNativeMapboxGLIOSVersion || ENV["REACT_NATIVE_MAPBOX_MAPBOX_IOS_VERSION"] || default_ios_mapbox_version
if ENV.has_key?("REACT_NATIVE_MAPBOX_MAPBOX_IOS_VERSION")
  puts "REACT_NATIVE_MAPBOX_MAPBOX_IOS_VERSION env is deprecated please use `$ReactNativeMapboxGLIOSVersion = \"#{rnmbgl_ios_version}\"`"
end

Pod::Spec.new do |s|
  s.name		= "react-native-mapbox-gl"
  s.summary		= "React Native Component for Mapbox GL"
  s.version		= package['version']
  s.authors		= { "Nick Italiano" => "ni6@njit.edu" }
  s.homepage    	= "https://github.com/@react-native-mapbox-gl/maps#readme"
  s.source      	= { :git => "https://github.com/@react-native-mapbox-gl/maps.git" }
  s.license     	= "MIT"
  s.platform    	= :ios, "13.0"

  s.dependency 'MapboxMaps', rnmbgl_ios_version
  s.dependency 'Turf'
  s.dependency 'React-Core'
  s.dependency 'React'
  s.swift_version = '5.0'
  s.subspec 'DynamicLibrary' do |sp|
    sp.source_files	= "ios/RCTMGL/**/*.{h,m,swift}"
    s.public_header_files = 'ios/RCTMGL/Bridge/*.h'
  end

  if ENV["REACT_NATIVE_MAPBOX_GL_USE_FRAMEWORKS"]
    s.default_subspecs= ['DynamicLibrary']
  else
    s.subspec 'StaticLibraryFixer' do |sp|
      s.dependency '@react-native-mapbox-gl-mapbox-mobile-events-static', rnmbgl_ios_version
      s.dependency '@react-native-mapbox-gl-mapbox-turf-static', rnmbgl_ios_version
    end

    s.default_subspecs= ['DynamicLibrary', 'StaticLibraryFixer']
  end
end
