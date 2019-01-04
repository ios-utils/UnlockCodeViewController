Pod::Spec.new do |s|
  s.name             = 'UnlockCodeViewController'
  s.version          = '0.1.0'
  s.summary          = 'A simple drop-in Unlock Code view controller.'

  s.description      = <<-DESC
  A simple drop-in Unlock Code view controller. Use this to add a simple gateway screen to prevent access to content.
                       DESC

  s.homepage         = 'https://github.com/reececomo/UnlockCodeViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Reece Como' => 'reece.como@gmail.com' }
  s.source           = { :git => 'https://github.com/reececomo/UnlockCodeViewController.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.4'
  s.swift_version = '4.2'

  s.source_files = 'UnlockCodeViewController/Classes/**/*'

end
