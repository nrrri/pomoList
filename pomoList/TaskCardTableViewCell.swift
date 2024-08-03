//
//  CustomTableViewCell.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-07-06.
//

import UIKit

// proocol
protocol TaskCardTableViewCellDelegate: AnyObject {
    func didTapButton(in cell: TaskCardTableViewCell)
    func tappedPlay(sender: TaskCardTableViewCell)
}

class TaskCardTableViewCell: UITableViewCell {
    
    weak var delegate: TaskCardTableViewCellDelegate?
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var pomodoroView: UIView!
    @IBOutlet weak var sessions: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    

        @IBAction func buttonTapped(_ sender: UIButton) {
            if let delegate = self.delegate {
                delegate.tappedPlay(sender: self)
            }
            
        }
}


    
