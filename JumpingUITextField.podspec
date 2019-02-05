Pod::Spec.new do |s|
  s.name = 'JumpingUITextField'
  s.version = '0.2.0'
  s.summary = 'Extension for UITextField written in swift 4.2'
  s.description = <<-DESC
                  Adding the ability to jump between UITextFields withing groups by using the return-key on the soft-keyboard
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
    ss.dependency 'LocalizableUIElements', '~> 1.0'
  end
end
