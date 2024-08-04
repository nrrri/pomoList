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
    
    @IBOutlet weak var currentDate: UILabel!
    
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
        todoList.sort { !$0.taskCompleted && $1.taskCompleted }
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
            
        } else {
            cell.pomodoroView.isHidden = false
            cell.sessions.text = "\(task.remainSession)/\(task.session)"
            
            // pomodoro session
            if (task.remainSession == 0) {
                cell.playButton.setTitle("COMPLETED", for: .disabled)
                cell.playButton.isEnabled = false
                cell.layer.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1).cgColor
                cell.title.textColor = UIColor(red: 130/255, green: 130/255, blue: 130/255, alpha: 1)
            }
        }
        
       
        
        // assigning delegate
        cell.delegate = self // Set the delegate
        
        return cell
    }

   // DELETE cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // update table when delete cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                todoList.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
            }
    }
    
    
    // Delegate for passing data to pomodoro vc
    
    func tappedPlay(sender: TaskCardTableViewCell) {
        
        let indexPath = tableView.indexPath(for: sender)
        
        // assign data to another view
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "PomodoroViewController") as? PomodoroViewController else {return}
        vc.pomodoroTitle = todoList[indexPath?.section ?? -1].name
        vc.totalSessions = todoList[indexPath?.section ?? -1].session
        vc.r_sessions = todoList[indexPath?.section ?? -1].remainSession
        
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    // Delegate update session from pomodoro vc
    func updateSessions(for taskName: String, remainingSessions: Int, checkComplete: Bool) {
            if let index = todoList.firstIndex(where: { $0.name == taskName }) {
                todoList[index].remainSession = remainingSessions
                todoList[index].taskCompleted = checkComplete
                tableView.reloadData()
//                tableView.reloadSections(IndexSet(integer: index), with: .automatic)
                print("update session: \(todoList[index].remainSession) & task status: \(todoList[index].taskCompleted)")
            }
        }
    
    
}
