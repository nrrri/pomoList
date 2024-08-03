//
//  CustomTableViewCell.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-07-06.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
static let identifier = "CustomTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: RGBGray200.red.value, green: RGBGray200.green.value, blue: RGBGray200.blue.value, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
