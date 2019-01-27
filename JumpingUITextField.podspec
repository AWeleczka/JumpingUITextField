Pod::Spec.new do |s|
  s.name = 'JumpingUITextField'
  s.version = '0.0.1'
  s.summary = 'An easy drop in to allow your user to advance to the next UITextField in a group by using the return-key'
  s.description = <<-DESC
                  An easy drop in to allow your user to advance to the next UITextField in a group by using the return-key
                  DESC
  s.homepage = 'https://github.com/AWeleczka/JumpingUITextField'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'AWeleczka' => 'github@accounts.aweleczka.de' }
  s.source = { :git => 'https://github.com/AWeleczka/JumpingUITextField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/AWeleczka'
  s.ios.deployment_target = '8.0'
  s.source_files = 'JumpingUITextField/JumpingUITextField/**/*'
  s.exclude_files = 'JumpingUITextField/JumpingUITextField/*.plist'
  s.subspec 'Localized' do |ss|
    ss.source_files = 'JumpingUITextField/LocalizedJumpingUITextField/**/*'
    ss.exclude_files = 'JumpingUITextField/LocalizedJumpingUITextField/*.plist'
    ss.dependency 'LocalizableUIElements', '~> 0.1.0'
  end
end
