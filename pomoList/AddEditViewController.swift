//
//  AddEditViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-14.
//

import UIKit

class AddEditViewController: UIViewController {
    var todoItem: TodoList?
    var onSave: (() -> Void)?
    var isEditingTask = false  // Flag to determine if we are editing [false = new item, true = edit item]
    
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
        
        // set UI
        roundCorner(view: titleView)
        roundCorner(view: detailView)
        roundCorner(view: pomodoroView)
        
        if let item = todoItem {
            titleName.text = item.name
            todoListDetail.text = item.description
            pomodoroToggle.isOn = item.isPomodoroActive
            sessions.selectedSegmentIndex = (Int(item.session) ?? 1) - 1
            isEditingTask = true
        }
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
        
        if isEditingTask, let index = todoList.firstIndex(where: { $0.id == todoItem?.id }) {
            // Update existing task
            todoList[index] = TodoList(id: todoList[index].id ,name: titleName.text ?? "", description: todoListDetail.text ?? "", isPomodoroActive: pomodoroToggle.isOn, session: setSession, remainSession: Int(setSession) ?? 0, isTaskComplete: todoList[index].isTaskComplete)
        } else {
            // Add new task
            let newTodoList = TodoList(id: UUID(), name: titleName.text ?? "", description: todoListDetail.text ?? "", isPomodoroActive: pomodoroToggle.isOn, session: setSession, remainSession: Int(setSession) ?? 0, isTaskComplete: false)
            todoList.append(newTodoList)
        }
        
        onSave?()  // Notify about the changes
        
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
