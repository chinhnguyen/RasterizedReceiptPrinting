//
//  AttributedString+Print.swift
//  Kiolyn
//
//  Created by Chinh Nguyen on 5/4/18.
//  Copyright © 2018 Willbe Technology. All rights reserved.
//

import Foundation
import UIKit

// Constants font type
let fontRegular = "TheSansMonoCondensed-Plain"
let fontBold = "TheSansMonoCondensed-SemiBold"
let fontRegularFileName = "TheSansMonoCondensed_Plain"
let fontBoldFileName = "TheSansMonoCondensed_Semi_Bold"
public let printingFontSizeBase: CGFloat = 24

// MARK: - Extension for rasterizing to image.
public extension NSAttributedString {
    /// Create raster image from `NSAttributedString` for printing.
    ///
    /// - Parameters:
    ///   - data: The data to rasterize.
    ///   - width: The width of the printing.
    /// - Returns: The `UIImage` of the data.
    public func rasterize(width: CGFloat) -> UIImage? {
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .truncatesLastVisibleLine]
        let dataRect = boundingRect(with: CGSize(width: width, height: 10000), options: options, context: nil)
        let dataSize = dataRect.size
        if UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)) {
            if UIScreen.main.scale == 2.0 {
                UIGraphicsBeginImageContextWithOptions(dataSize, false, 1.0)
            } else {
                UIGraphicsBeginImageContext(dataSize)
            }
        } else {
            UIGraphicsBeginImageContext(dataSize)
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        UIColor.white.set()
        let rect = CGRect(x: 0, y: 0, width: dataSize.width + 1, height: dataSize.height + 1)
        context.fill(rect)
        self.draw(in: rect)
        // Build the image
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}

/// Extension NSMutableAttributedString to append string with NSAttributedString
public extension NSMutableAttributedString {
    
    public func appendX2(_ text: String) {
        self.append(text, bold: false, center: false, size: printingFontSizeBase*2)
    }
    public func appendX15(_ text: String) {
        self.append(text, bold: false, center: false, size: printingFontSizeBase*1.3)
    }
    public func appendCenter(_ text: String) {
        self.append(text, bold: false, center: true)
    }
    public func appendCenterX2(_ text: String) {
        self.append(text, bold: false, center: true, size: printingFontSizeBase*2)
    }
    public func appendBold(_ text : String) {
        self.append(text, bold: true)
    }
    public func appendBoldCenter(_ text : String) {
        self.append(text, bold: true, center: true)
    }
    public func appendBoldX2(_ text : String) {
        self.append(text, bold: true, center: false, size: printingFontSizeBase*2)
    }
    public func appendBoldX25(_ text : String) {
        self.append(text, bold: true, center: false, size: printingFontSizeBase*2.5)
    }
    public func appendBoldCenterX2(_ text : String) {
        self.append(text, bold: true, center: true, size: printingFontSizeBase*2)
    }
    public func appendGroupSeperateLine(_ text : String) {
        self.append(text, bold: false, center: true, size: printingFontSizeBase*2, isGroupLine: true)
    }
    public func appendPrintLargeTableName(_ text : String) {
        self.append(text, bold: true, center: true, size: printingFontSizeBase*3, isGroupLine: false, underline: true)
    }
    
    /// Append a string with custom style.
    ///
    /// - Parameters:
    ///   - text: The text to append.
    ///   - bold: `true` to format as bold.
    ///   - center: `true` to center aligned.
    ///   - fontSize: the size of the text.
    ///   - isGroupLine: check for case is seperate line
    public func append(_ text: String, bold: Bool = false, center: Bool = false, size fontSize: CGFloat = printingFontSizeBase, isGroupLine: Bool = false) {
        self.append(text, bold: bold, center: center, size: fontSize, isGroupLine: isGroupLine, underline: false)
    }
    
    /// Append a string with custom style.
    ///
    /// - Parameters:
    ///   - text: The text to append.
    ///   - bold: `true` to format as bold.
    ///   - center: `true` to center aligned.
    ///   - fontSize: the size of the text.
    ///   - underline: text underlining
    public func append(_ text: String, bold: Bool = false, center: Bool = false, size fontSize: CGFloat = printingFontSizeBase, isGroupLine: Bool = false, underline: Bool = false) {
        if let font = UIFont(name: bold ? fontBold : fontRegular, size: fontSize) {
            append(text, font: font, center: center, isGroupLine: isGroupLine, underline: underline)
        } else {
            UIFont.loadAllFonts()
            if let font = UIFont(name: bold ? fontBold : fontRegular, size: fontSize) {
                append(text, font: font, center: center, isGroupLine: isGroupLine, underline: underline)
            }
        }
    }
    
    
    /// Append text with specific font.
    ///
    /// - Parameters:
    ///   - text: the text to append
    ///   - font: the font to be used
    ///   - center: center text
    ///   - underline: underline text
    public func append(_ text: String, font: UIFont, center: Bool = false, isGroupLine: Bool = false, underline: Bool = false) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10.0
        paragraph.alignment = center ? .center : .left
        if isGroupLine {
            paragraph.paragraphSpacing = 16.0
            paragraph.lineSpacing = 0.0
        }
        var attributes = [
            NSAttributedStringKey.backgroundColor: isGroupLine ? UIColor.black : UIColor.clear,
            NSAttributedStringKey.foregroundColor: isGroupLine ? UIColor.white : UIColor.black,
            NSAttributedStringKey.font: font as Any,
            NSAttributedStringKey.paragraphStyle: paragraph]
        if underline {
            attributes[NSAttributedStringKey.underlineColor] = UIColor.black
            attributes[NSAttributedStringKey.underlineStyle] = NSUnderlineStyle.styleThick.rawValue
        }
        self.append(NSAttributedString(string: text, attributes: attributes))
    }
    
    /// Append an image for printing purpose.
    ///
    /// - Parameter image: the image to append.
    public func appendImage(_ image: UIImage, height: CGFloat = 120) {
        let textAttachment = NSTextAttachment()
        let ratio = image.size.width / image.size.height
        let with = height * ratio
        textAttachment.bounds = CGRect(x: 0, y: 0, width: with, height: height)
        textAttachment.image = image
        
        let iconString = NSAttributedString(attachment: textAttachment)
        let logoString = NSMutableAttributedString(attributedString: iconString)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 12.0
        paragraph.alignment = .center
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraph]
        logoString.addAttributes(attributes, range: NSMakeRange(0, iconString.length))
        append(logoString)
        append("\n")
    }
}


extension UIFont {
    
    class func loadAllFonts() {
        registerFont(fontRegularFileName)
        registerFont(fontBoldFileName)
    }
    
    class func registerFont(_ name: String) {
        guard let frameworkBundle = Bundle(identifier: "org.cocoapods.RasterizedReceiptPrinting"),
            let resourceURL = frameworkBundle.resourceURL?.appendingPathComponent("RasterizedReceiptPrinting.bundle"),
            let resourceBundle = Bundle(url: resourceURL),
            let pathForResourceURL = resourceBundle.url(forResource: name, withExtension: "ttf"),
            let fontData = NSData(contentsOf: pathForResourceURL),
            let dataProvider = CGDataProvider(data: fontData),
            let fontRef = CGFont(dataProvider) else {
                print("RasterizedReceiptPrinting: Failed to load fonts.")
                return
        }
        var errorRef: Unmanaged<CFError>? = nil
        if !CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) {
            print("RasterizedReceiptPrinting: Failed to register fonts. Error: \(errorRef.debugDescription)")
        }
    }
    
}





