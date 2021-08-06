# Uncomment the next line to define a global platform for your project
platform :ios, '14.5'

target 'Messenger' do
  use_frameworks!

#Firebase
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database' 
pod 'Firebase/Storage' 

#Facebook
pod 'FBSDKLoginKit'

#Google Sign In
pod 'GoogleSignIn', '5.0.2'

pod 'MessageKit'
pod 'JGProgressHUD'
pod 'SDWebImage'
pod 'RealmSwift'




end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.5'
    end
  end
end