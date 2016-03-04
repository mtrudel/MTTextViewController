Pod::Spec.new do |s|
  s.name         = "MTTextViewController"
  s.version      = "1.1.0"
  s.summary      = "A simple delegate based text entry view controller"
  s.homepage     = "https://github.com/mtrudel/MTTextViewController"
  s.license      = 'MIT'
  s.author       = { "Mat Trudel" => "mat@geeky.net" }
  s.source       = { :git => "https://github.com/mtrudel/MTTextViewController.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
end
