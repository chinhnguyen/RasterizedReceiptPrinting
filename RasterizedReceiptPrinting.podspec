Pod::Spec.new do |s|
  s.name             = 'RasterizedReceiptPrinting'
  s.version          = '0.1.0'
  s.summary          = 'Receipt printing to POS printer with support for Unicode'
  s.ios.deployment_target = '9.3'
  s.description      = <<-DESC
Printing Unicode with Command mode to Receipt printers are not reliable. The best solution so far is to printing to a UIImage and then send the whole image over to printer.
With this approach, developer can control totally the Unicode printing work and it''s easier to manage the layout.
However, Mono-Font must be used to make alignment more precise.
                       DESC

  s.homepage         = 'https://github.com/chinhnguyen/RasterizedReceiptPrinting'
  s.screenshots     = 'https://photos.google.com/share/AF1QipPGnVaAF9p2uC5p2v8YWzSR04UhveV62IHa3i5bqNFf5l9TV5BFH06c0n8xtEdy2g?key=MVNvN3JtVTNmdmRjSlNWeDRtLUttU0p3RDBXWjdB'
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
end
