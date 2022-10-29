//
//  Extensions.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/27/22.
//

import Foundation
import SwiftUI


extension Color {
    static func EggShellColor() -> Color {
        return Color(red: 244/255, green: 235/255, blue: 217/255)
    }
    
    static func SpaceCadetColor() -> Color {
        return Color(red: 43/255, green: 45/255, blue: 66/255)
    }
    
    static func BtnPinkColor() -> Color {
        return Color(red: 244/255, green: 65/255, blue: 116/255)
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
