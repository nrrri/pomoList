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
        roundCorner(view: titleView)
        roundCorner(view: detailView)
        roundCorner(view: pomodoroView)
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
    
    @IBAction func saveList(_ sender: UIButton) {
        guard let title = titleName.text, !title.isEmpty else {
                showAlert(message: "Title cannot be empty")
                return
            }

        let newTodoList = TodoList(name: titleName.text ?? "", description: todoListDetail.text ?? "", isActive: pomodoroToggle.isOn, ss: setSession, rss: Int(setSession) ?? 0)
        todoList.append(newTodoList)

        // navigate back to homepage
        guard let vc = storyboard?.instantiateViewController(identifier: "MainViewController") as? MainViewController else {return}
            
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
