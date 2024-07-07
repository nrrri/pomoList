//
//  CustomTableViewCell.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-07-06.
//

import UIKit

class TaskCardTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    
    @IBOutlet weak var pomodoroView: UIView!
    
    @IBOutlet weak var sessions: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    var tappedBtn: (() -> ())?
    @IBAction func tappedPlay(_ sender: UIButton) {
        tappedBtn?()
        print("tap")
    }
    
}
    
