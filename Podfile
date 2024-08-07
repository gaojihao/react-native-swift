# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'

require Pod::Executable.execute_command('node', ['-p',
  'require.resolve(
    "react-native/scripts/react_native_pods.rb",
    {paths: [process.argv[1]]},
  )', __dir__]).strip

  platform :ios, min_ios_version_supported
  prepare_react_native_project!

target 'react-native-swift' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # 布局
  pod 'SnapKit'


  
  config = use_native_modules!

    use_react_native!(
      :path => "./node_modules/react-native",
      :hermes_enabled => false,
      :fabric_enabled => false,
      :app_path => "./"
    )

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['ARCHS'] = '${ARCHS_STANDARD_64_BIT}'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
