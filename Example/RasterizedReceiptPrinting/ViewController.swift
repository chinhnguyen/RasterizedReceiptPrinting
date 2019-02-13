//
//  ViewController.swift
//  RasterizedReceiptPrinting
//
//  Created by chinhnguyen on 01/21/2019.
//  Copyright (c) 2019 chinhnguyen. All rights reserved.
//

import UIKit
import RasterizedReceiptPrinting

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let data = buildTemplate()
        // TSP 100 3 inches = 576
        if let image = data.rasterize(width: 576) {
            do {
                let filePath = try image.save(toTempDirectory: "sample.png")
                print("Printed to \(filePath)")
            } catch {
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// Build string template for printing items.
    ///
    /// - Parameters:
    ///   - items: The `Item`s to print.
    ///   - order: The `Order` that the orders belong to.
    ///   - server: The server who request the printing.
    ///   - type: The type of printing.
    ///   - ds: The data service for querying data.
    /// - Returns: The data to be printed as `NSAttributedString`.
    /// - Throws: `PrintError`.
    func buildTemplate() -> NSAttributedString {
        // The final data
        let data = NSMutableAttributedString(string: "")
        
        data.append("\n\n\n")
        data.append("Server: Chinh Nguyen\n")
        data.append("\n")
        let time = Date()
        let dateValueString = time.toString("MM/dd/yyyy")
        let timeValueString = time.toString("HH:mm:ss")
        data.append("\(dateValueString)                              \(timeValueString)\n")
        // Order #                              #Guests:  4
        data.appendX2("Order#: \(String(format: "%d", 11))     \(String(format: "Guests:%2d", 4))\n")
//        // TABLE 5
//        let tableName = settings.printTableNo ? order.displayName : ""
//        data.appendBoldX25("\(tableName.exact(14))\n")
//
//        var status: String!
//        switch type {
//        case .void: status = " (VOID)"
//        case .resend: status = " (RESEND)"
//        case .send: status = "" }
//        data.appendCenterX2("\(status!)\n")
//
//        // The Items
//        //data.appendX2("------------------------\n")
//
//        func add(items: [OrderItem]) {
//            for item in items {
//                // Updated status line
//                if item.isUpdated {
//                    data.appendX2("    [UPDATED]\n")
//                }
//                // Name line
//                var name = item.samelineName
//                let name2 = item.samelineName2
//                // Mark as togo
//                if item.togo { name = "[TOGO] \(name)" }
//                // Print items (voided items with minus sign)
//                if (type == .void) {
//                    data.appendX2("-\(item.asPrintingCount) \(name.left(19))\n")
//                    if name.count > 19 {
//                        data.appendX2("     \(name.right(from: 19))\n")
//                    }
//                    // Name 2
//                    if settings.printItemsName2, name2.isNotEmpty {
//                        data.appendX2("     \(name2.left(19))\n")
//                    }
//                    if settings.printItemsName2, name2.isNotEmpty, name2.count > 19 {
//                        data.appendX2("     \(name2.right(from: 19))\n")
//                    }
//                } else {
//                    data.appendX2("\(item.asPrintingCount) \(name.left(20))\n")
//                    if (name.count > 20) {
//                        data.appendX2("    \(name.right(from: 20))\n")
//                    }
//                    // Name 2
//                    if settings.printItemsName2, name2.isNotEmpty {
//                        data.appendX2("    \(name2.left(19))\n")
//                    }
//                    if settings.printItemsName2, name2.isNotEmpty, name2.count > 19 {
//                        data.appendX2("     \(name2.right(from: 19))\n")
//                    }
//                }
//                // Print Note
//                if settings.printNote, item.note.isNotEmpty {
//                    data.appendX2("    >>\(item.note.left(17))\n")
//                    if item.note.count > 17 {
//                        data.appendX2("      \(item.note.right(from: 17))\n")
//                    }
//                }
//                // Print modifiers
//                if settings.printModifier {
//                    for opt in item.options {
//                        let optName = opt.0
//                        data.appendX2("    >>\(optName.left(17))\n")
//                        if (optName.count > 17) {
//                            data.appendX2("      \(optName.right(from: 17))\n")
//                        }
//                    }
//                }
//                // Separator should be printed if
//                // 1. The printLineSeparator settings is ON
//                // 2. and either
//                //      2.1 No Print Grouping
//                //      2.2 Or item is not the last item
//                if settings.printLineSeparator && (!settings.printGrouping || item != items.last!) {
//                    data.appendX2("------------------------\n")
//                }
//            }
//        }
//        // Group by category (issue #487)
//        if settings.printGrouping {
//            var categoryItems: [String:[OrderItem]] = [:]
//            // Group order items by its category id
//            for item in items {
//                categoryItems[item.categoryID] = (categoryItems[item.categoryID] ?? []) + [item]
//            }
//            // This seems to be redundant however, we keep it here to honor the order of category
//            let categories: [Category?] = try await(ds.load(multi: categoryItems.keys.unique()))
//            let groupedItems: [(Category, [OrderItem])] = categories
//                // Remove the nil Category, this is rarely happens, but just in case
//                .filter { $0 != nil }
//                .map { $0! }
//                // Sort category by its order
//                .sorted { (cat1, cat2) -> Bool in cat1.order < cat2.order }
//                // Replace category id with category
//                .compactMap { category -> (Category, [OrderItem]) in
//                    return (category, categoryItems[category.id]!)
//            }
//
//            // Print items
//            for (_, items) in groupedItems {
//                data.appendGroupSeperateLine("************************\n")
//                add(items: items)
//            }
//        } else {
//            add(items: items)
//        }
//
//        // Print customer information
//        if order.customer.isNotEmpty,
//            // load and make sure customer can be loaded
//            let customer: Customer = try await(ds.load(order.customer)) {
//            data.append("\n")
//            if !settings.printLineSeparator {
//                data.appendX2("------------------------\n")
//            }
//            if customer.name.count > 13 {
//                data.appendX2("\(customer.name)\n")
//                data.appendX2("\(customer.mobilephone.formattedPhone)\n")
//            } else {
//                data.appendX2("\(customer.name) \(customer.mobilephone.formattedPhone)\n")
//            }
//            data.appendX2("\([customer.address, customer.city, customer.state].joined(separator: ", ")) \(customer.zip)\n\n")
//        }
//
//        if order.area.isNotEmpty,
//            // Add bottom large text for ToGo or Delivery Table
//            let area: Area = try await(ds.load(order.area)) {
//            if (area.isToGo || area.isDelivery)  {
//                data.appendX2("------------------------\n")
//                data.append("\n")
//                data.appendPrintLargeTableName(order.areaName)
//            }
//        }
//
        // 2 spaces at bottom
        data.append("\n\n")
        return data
    }
}

extension Date {
    
    /// Short firm to string with format.
    ///
    /// - Parameter dateFormat: The format.
    /// - Returns: The date formatted with given format.
    func toString(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
}

extension UIImage {
    
    /// Save the current image to temp directory under given name.
    ///
    /// - Parameter file: the file name.
    /// - Throws: throws if the png image could not be created.
    func save(toTempDirectory file: String) throws -> String{
        return try save(to: NSTemporaryDirectory().appending(file))
    }
    
    /// Save the current image to the given file path.
    ///
    /// - Parameter filePath: the file path.
    /// - Throws: throws if the png image could not be created.
    func save(to filePath: String) throws -> String {
        guard let fileURL = URL(string: "file://\(filePath)"), let png = UIImagePNGRepresentation(self) else {
            return ""
        }
        try png.write(to: fileURL)
        return filePath
    }
}

