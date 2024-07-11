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
        
        setUIMonth(label: currentMonth)
//        setCurrentDate(label: currentDate)
        
//        count += 1
//        print(">>> IN MAIN -- \(count)")
//        print("num of list: \(demo.count)")
//        print(demo)
        
        if todoList.count == 0 {
            planForTheDay.text = "No Task Today, Let's add new task!"
        } else {
            planForTheDay.text = "Plan For The Day"
            setTableView()
        }
        
        
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
    
    func setCurrentDate(label: UILabel) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("d")
        label.text = dateFormatter.string(from: date)
    }

}

extension MainViewController: UITableViewDataSource, TaskCardTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCardTableViewCell", for: indexPath) as! TaskCardTableViewCell

        // import array
        let task = todoList[indexPath.section]
        cell.layer.cornerRadius = 16
        
        // task's name
        cell.title.text = task.name.uppercased()
        
        // detail
        cell.detail.text = task.description
        
        if !(task.isPomodoroActive) {
            cell.pomodoroView.isHidden = true
            
        } else {
            cell.pomodoroView.isHidden = false  
            
            // pomodoro session
            cell.sessions.text = task.session
        }
        
        cell.delegate = self // Set the delegate
        
        return cell
    }
    
    func didTapButton(in cell: TaskCardTableViewCell) {
        print("Click play!")
            // Find the indexPath for the cell
        if let indexPath = tableView.indexPath(for: cell) {
//                let task = todoList[indexPath.section]
                // Perform navigation to PomodoroViewController
                let vc = storyboard?.instantiateViewController(withIdentifier: "PomodoroViewController") as! PomodoroViewController

                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
    
}
