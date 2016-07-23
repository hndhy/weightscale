source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'

pod 'AFNetworking', '~> 2.5.0'
pod 'iToast', '~> 0.0.1'
pod 'JSONModel', '~> 1.1.0'
pod 'SDWebImage', '~> 3.7.1'
pod 'UICKeyChainStore', '~> 1.1.0'
pod 'Reachability', '~> 3.2'
pod 'NYXImagesKit', '~> 2.3'
pod 'MBProgressHUD', '~> 0.9'
pod 'RESideMenu', '~> 4.0.7'
pod 'LKDBHelper', :head

post_install do |installer_representation|
  installer_representation.project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    end
  end
end