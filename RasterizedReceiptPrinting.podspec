Pod::Spec.new do |s|
  s.name             = 'RasterizedReceiptPrinting'
  s.version          = '0.1.4'
  s.summary          = 'Receipt printing to POS printer with support for Unicode'
  s.ios.deployment_target = '9.3'
  s.description      = <<-DESC
Printing Unicode with Command mode to Receipt printers are not reliable. The best solution so far is to printing to a UIImage and then send the whole image over to printer.
With this approach, developer can control totally the Unicode printing work and it''s easier to manage the layout.
However, Mono-Font must be used to make alignment more precise.
                       DESC

  s.homepage         = 'https://github.com/chinhnguyen/RasterizedReceiptPrinting'
  s.screenshots      = 'https://raw.githubusercontent.com/chinhnguyen/RasterizedReceiptPrinting/master/receipt_thermal.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chinhnguyen' => 'chinh@willbe.vn' }
  s.source           = { :git => 'https://github.com/chinhnguyen/RasterizedReceiptPrinting.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ngtr9h'
  s.ios.deployment_target = '9.0'
  s.source_files = 'RasterizedReceiptPrinting/Classes/**/*'
  s.resource_bundles = {
      'RasterizedReceiptPrinting' => ['RasterizedReceiptPrinting/Assets/*.ttf']
  }
  s.framework = 'UIKit'
  s.swift_version = '4.0'
end
