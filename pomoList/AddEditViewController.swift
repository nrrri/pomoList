//
//  AddEditViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-14.
//

import UIKit

class AddEditViewController: UIViewController {

    var setSession: String = "1"
    
    // create list
    // title
    @IBOutlet var titleView: UIView!
    @IBOutlet var titleName: UITextField!
    // detail
    @IBOutlet var detailView: UIView!
    @IBOutlet var todoListDetail: UITextField!
    
    // create pomodoro
    @IBOutlet var pomodoroView: UIView!
    @IBOutlet var sessions: UISegmentedControl!
    @IBOutlet var pomodoroToggle: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorner()
    }
    
    func roundCorner() {
        let roundCorner:CGFloat = 16
        // round corner
        titleView.layer.cornerRadius = roundCorner
        detailView.layer.cornerRadius = roundCorner
        pomodoroView.layer.cornerRadius = roundCorner
    }
    
    @IBAction func setPomodoroActive(_ sender: UISwitch) {
        if pomodoroToggle.isOn {
            sessions.isEnabled = true
        } else {
            sessions.isEnabled = false
            setSession = "0"
        }
    }
    
    @IBAction func setPomodoroSessions(_ sender: UISegmentedControl) {
       
            switch sender.selectedSegmentIndex {
            case 0:
                setSession = "1"
            case 1:
                setSession = "2"
            case 2:
                setSession = "3"
            case 3:
                setSession = "4"
            case 4:
                setSession = "5"
            default:
                setSession = "0"
            }
    }
    
    func setNewTask () {
        let newTask = TodoList(taskName: titleName.text ?? "a", description: todoListDetail.text ?? "a", isActive: pomodoroToggle.isOn, session: setSession)
        tasks.append(newTask)
    }
    
    @IBAction func saveList(_ sender: UIButton) {
//        setNewTask()
        print("click")
        let dummy = Demo(name: titleName.text ?? "", description: todoListDetail.text ?? "", isActive: pomodoroToggle.isOn, ss: setSession)
        demo.append(dummy)
        
        print(demo)
        // navigate back to homepage
        let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        vc.modalPresentationStyle = .fullScreen

        present(vc, animated: true, completion: nil)
    }

}
