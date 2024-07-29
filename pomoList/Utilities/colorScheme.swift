//
//  colorScheme.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-07-06.
//
import UIKit
import Foundation

enum RGBGray200: CGFloat {
    // #B5B5B5
    case red
    case blue
    case green
    
    var value: CGFloat {
        switch self {
        case .red:
            return 181 / 255.0
        case .green:
            return 181 / 255.0
        case .blue:
            return 181 / 255.0
        }
    }
    
    var color: UIColor {
            return UIColor(red: RGBGray200.red.value, green: RGBGray200.green.value, blue: RGBGray200.blue.value, alpha: 1.0)
        }
}

enum RGBGray100: CGFloat {
    // #B5B5B5
    case red
    case blue
    case green
    
    var value: CGFloat {
        switch self {
        case .red:
            return 217 / 255.0
        case .green:
            return 217 / 255.0
        case .blue:
            return 217 / 255.0
        }
    }
    
    var color: UIColor {
            return UIColor(red: RGBGray200.red.value, green: RGBGray200.green.value, blue: RGBGray200.blue.value, alpha: 1.0)
        }
}
