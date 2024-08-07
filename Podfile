# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'

require Pod::Executable.execute_command('node', ['-p',
  'require.resolve(
    "react-native/scripts/react_native_pods.rb",
    {paths: [process.argv[1]]},
  )', __dir__]).strip

  platform :ios, '15.0'
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
    
    post_install do |installer|
        # https://github.com/facebook/react-native/blob/main/packages/react-native/scripts/react_native_pods.rb#L197-L202
        react_native_post_install(
          installer,
          config[:reactNativePath],
          :mac_catalyst_enabled => false,
          # :ccache_enabled => true
        )
      end

end
