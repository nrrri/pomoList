//
//  AddEditViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-14.
//

import UIKit

class AddEditViewController: UIViewController {

    // create list
    // title
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleName: UITextField!
    // date
    @IBOutlet var dateView: UIView!
    @IBOutlet var setDate: UIDatePicker!
    // time
    @IBOutlet var timeView: UIView!
    @IBOutlet var timeToggle: UISwitch!
    @IBOutlet var setTime: UIDatePicker!
    // tag
    @IBOutlet var tagView: UIView!
    @IBOutlet var tags: UITextField!
    // detail
    @IBOutlet var detailView: UIView!
    @IBOutlet var datail: UITextField!
    
    // create pomodoro
    @IBOutlet var pomodoroView: UIView!
    @IBOutlet var sessions: UISegmentedControl!
    @IBOutlet var pomodoroToggle: UISwitch!
    
    @IBOutlet var saveBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorner()
    }
    
    func roundCorner() {
        let roundCorner:CGFloat = 16
        // round corner
        titleView.layer.cornerRadius = roundCorner
        dateView.layer.cornerRadius = roundCorner
        timeView.layer.cornerRadius = roundCorner
        tagView.layer.cornerRadius = roundCorner
        detailView.layer.cornerRadius = roundCorner
        pomodoroView.layer.cornerRadius = roundCorner
    }
    
    @IBAction func saveList(_ sender: UIButton) {
        
    }
    
    func createList(){
        
    }

}
