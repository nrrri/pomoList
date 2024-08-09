//
//  ViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-14.
//

import UIKit


class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var currentMonth: UILabel!
    
    @IBOutlet weak var planForTheDay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setUIMonth(label: currentMonth)
        
        
        if todoList.count == 0 {
            planForTheDay.text = "No Task Today, Let's add new task!"
        } else {
            planForTheDay.text = "Plan For The Day"
            setTableView()
            sortTodoList() // Sort tasks initially
            tableView.reloadData()
        }
        
        
    }
    
    func sortTodoList() {
        todoList.sort { !$0.isTaskComplete && $1.isTaskComplete }
    }
    
    func setTableView() {
        tableView.frame = view.bounds
        tableView.rowHeight = 124
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func setUIMonth(label: UILabel) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        label.text = dateFormatter.string(from: date)
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, TaskCardTableViewCellDelegate, PomodoroViewControllerDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCardTableViewCell", for: indexPath)
                as? TaskCardTableViewCell else {return UITableViewCell()}
        
        // import array
        sortTodoList()
        let task = todoList[indexPath.section]
        
        roundCorner(view: cell)
        
        // task's name
        cell.title.text = task.name?.uppercased()
        
        // detail
        cell.detail.text = task.description
        
        if !(task.isPomodoroActive) {
            cell.pomodoroView.isHidden = true
            let margins = cell.layoutMarginsGuide
            cell.detail.trailingAnchor.constraint(equalTo: margins.trailingAnchor , constant: 0).isActive = true
            
        } else {
            cell.pomodoroView.isHidden = false
            cell.sessions.text = "\(task.remainSession)/\(task.session)"
        }
        
        // pomodoro session
        if (task.isTaskComplete == true) {
            cell.playButton.setTitle("COMPLETED", for: .disabled)
            cell.playButton.isEnabled = false
            cell.layer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
            cell.title.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
            cell.detail.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
        }
        
        // assigning delegate
        cell.delegate = self // Set the delegate
        
        return cell
    }
    
    
    // EDIT/DELETE data
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Delete item
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            todoList.remove(at: indexPath.section)
            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            completionHandler(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, completionHandler) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController else {return}
            
            // Pass the selected task data
            let selectedTask = todoList[indexPath.section]
            
            vc.todoItem = selectedTask
            vc.onSave = {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            // Present the view controller
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        // Set finish item
        let finishAction = UIContextualAction(style: .normal, title: "Finish") { (_, _, completionHandler) in
            todoList[indexPath.section].isTaskComplete = true
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        // set UI color
        editAction.backgroundColor = .systemBlue
        finishAction.backgroundColor = .systemGreen
        
        // set function order
        var swipeActions = UISwipeActionsConfiguration()
        // Combine actions into configuration
        if (todoList[indexPath.section].isTaskComplete == false) {
            swipeActions = UISwipeActionsConfiguration(actions: [deleteAction,editAction,finishAction])
        } else {
            swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        }
        
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions
    }
    
    
    // Delegate for passing data to pomodoro vc
    
    func tappedPlay(sender: TaskCardTableViewCell) {
        
        let indexPath = tableView.indexPath(for: sender)
        let task = todoList[indexPath?.section ?? -1]
        
        // assign data to another view
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PomodoroViewController") as? PomodoroViewController else {return}
        
        // passing data
        vc.pomodoroID = task.id
        vc.pomodoroTitle = task.name
        vc.totalSessions = task.session
        vc.r_sessions = task.remainSession
        
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    // Delegate update session from pomodoro vc
    func updateSessions(for taskID: UUID, remainingSessions: Int, checkComplete: Bool) {
        if let index = todoList.firstIndex(where: { $0.id == taskID }) {
            todoList[index].remainSession = remainingSessions
            todoList[index].isTaskComplete = checkComplete
            tableView.reloadData()
        }
    }
    
}
