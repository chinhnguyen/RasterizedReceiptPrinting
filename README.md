# RasterizedReceiptPrinting

[![CI Status](https://img.shields.io/travis/chinhnguyen/RasterizedReceiptPrinting.svg?style=flat)](https://travis-ci.org/chinhnguyen/RasterizedReceiptPrinting)
[![Version](https://img.shields.io/cocoapods/v/RasterizedReceiptPrinting.svg?style=flat)](https://cocoapods.org/pods/RasterizedReceiptPrinting)
[![License](https://img.shields.io/cocoapods/l/RasterizedReceiptPrinting.svg?style=flat)](https://cocoapods.org/pods/RasterizedReceiptPrinting)
[![Platform](https://img.shields.io/cocoapods/p/RasterizedReceiptPrinting.svg?style=flat)](https://cocoapods.org/pods/RasterizedReceiptPrinting)

Printing Unicode with Command mode to Receipt printers are not reliable. The best solution so far is to printing to a UIImage and then send the whole image over to printer.
With this approach, developer can control totally the Unicode printing work and it''s easier to manage the layout.
However, Mono-Font must be used to make alignment more precise.

<img src="https://github.com/chinhnguyen/RasterizedReceiptPrinting/blob/master/receipt_thermal.png" data-canonical-src="https://github.com/chinhnguyen/RasterizedReceiptPrinting/blob/master/receipt_thermal.png" width="300" height="630" />

## Usage

Firstly, we must create a `NSAttributedString`.

- **Implement Swift**:

    ```swift
    let printTemplate = NSMutableAttributedString(string: "")
    ```

Then, we can append new attributed string for this template like this.

- **Implement Swift**:

    ```swift
    printTemplate.append("Hello World!!!\n")
    printTemplate.appendCenter("This is a center body.\n")
    printTemplate.appendBold("End World!!!\n")
    ```

Finally, create image from custom string with page width setting.

- **Implement Swift**:

    ```swift
    let image = printTemplate.rasterize(width: 576)
    ```

Congratulations! You're done. 🎉

## Installation

RasterizedReceiptPrinting is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RasterizedReceiptPrinting'
```

## Before using module

#### Swift

Add the following line in your Swift file: 

```swift
import RasterizedReceiptPrinting
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 4.0
- iOS 9.0 or later

## Author

* Chinh Nguyen, chinh@willbe.vn
* Tien Pham, phduytien4891@gmail.com

## License

RasterizedReceiptPrinting is available under the MIT license. See the LICENSE file for more info.
