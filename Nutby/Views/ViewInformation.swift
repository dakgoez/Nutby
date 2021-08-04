//
//  ViewInformation.swift
//  Nutby
//
//  Created by Diren Akgöz on 08.06.21.
//

import Foundation
import UIKit
import SwiftUI

class ViewInformation {
    
    // Getter - CornerRadius
    func getCR() -> CGFloat {
        return 10
    }
    
    // Getter - Länge eines Rounded Rectangle
    func getRRWidth() -> CGFloat {
        return 390
    }
    
    // Getter - Hellgrau als Hexadezimalwert
    func getLightGray() -> Int {
        return 0xe5e5e5
    }
    
    // Getter - Babyblau als Hexadezimalwert
    func getBabyBlueColor() -> Int {
        return 0xC1DFFE
    }
    
    // Getter - Babyblau als UIColor
    func getBabyBlueUIC() -> UIColor {
        return UIColor(red: 0.76, green: 0.87, blue: 1.00, alpha: 1.00)
    }
    
    // Getter - Dunkelblau als Hexadezimalwert
    func getDarkBlueColor() -> Int {
        return 0x0060C4
    }
    
    // Getter - Dunkelblau als UIColor
    func getDarkBlueUIC() -> UIColor {
        return UIColor(red: 0.00, green: 0.38, blue: 0.77, alpha: 1.00)
    }
    
    // Getter - Standartlänge unserer RoundedRectangle
    func getWidth() -> CGFloat {
        return 250
    }
    
    // Getter - Standarthöhe unserer RoundedRectangle
    func getHeight() -> CGFloat {
        return 30
    }
    
    // Getter - Standartlänge unserer Button
    func getButtonWidth() -> CGFloat {
        return 150
    }
    
    // Getter - Standarthöhe unserer Button
    func getButtonHeight() -> CGFloat {
        return 50
    }
    
    // Getter - Baby und UIImage entgegennehmen -> UIImage in Image umwandeln -> Image ausgeben
    func getPicture(enteredBaby: Babies, uiPicture: UIImage) -> Image {
        let uiPicture = UIImage(data: enteredBaby.picture!)
        return Image(uiImage: uiPicture!)
    }
    
    // Getter - Gibt einen DateFormatter zurück, welcher das Datum in "DD.MM.YYYY" darstellt
    func getDateFormatter_Date() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd.MM.y"
        return dateFormatter
    }
    
    // Getter - Gibt einen DateFormatter zurück, welcher das Datum in "DD.MM.YYYY - HH:MM" darstellt
    func getDateFormatter_DateAndTime() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "dd.MM.y - HH:mm"
        return dateFormatter
    }
}

extension Color {
    init(hex: Int, alpha: Double = 1) {
        let components = (
            R: Double((hex >> 16) & 0xff) / 255,
            G: Double((hex >> 08) & 0xff) / 255,
            B: Double((hex >> 00) & 0xff) / 255
        )
        self.init(
            .sRGB,
            red: components.R,
            green: components.G,
            blue: components.B,
            opacity: alpha
        )
    }
}
