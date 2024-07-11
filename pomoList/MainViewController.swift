//
//  ViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-14.
//

import UIKit

class MainViewController: UIViewController {
    
//    let tasks = [
//        Task(taskName: "Study Math", date: Date(), time: "10:00 AM", description: "sdfgnkdlsagnl", pomodoro: Pomodoro(isActive: true, session: "1")),
//        Task(taskName: "Working on Final project", date: Date(), time: "4:00 PM", description: "df,gnad;flkhnfape;dlhna;hgb", pomodoro: Pomodoro(isActive: true, session: "2")),
//        Task(taskName: "Reading book", date: Date(), time: "8:00 PM", description: "dksghldksa;gkdnsa;gkhdsa;gnkds;a", pomodoro: Pomodoro(isActive: false, session: ""))
//    ]
    
//    var tasks = [(TodoList(taskName: "Test1", description: "des 1", isActive: true, session: "1"))]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var currentMonth: UILabel!
    
    @IBOutlet weak var currentDate: UILabel!
    
    @IBOutlet weak var planForTheDay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIMonth(label: currentMonth)
//        setCurrentDate(label: currentDate)
        
        count += 1
        print(">>> IN MAIN - will appear \(count)")
        print("num of tasks \(demo.count)")
        print(demo)
        
        if demo.count == 0 {
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

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // broken here
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCardTableViewCell", for: indexPath) as! TaskCardTableViewCell

        // import array
        let task = demo[indexPath.section]
        cell.layer.cornerRadius = 16
        
        // task's name
        cell.title.text = task.name
        
        // detail
        cell.detail.text = task.description
        
        if !(task.isPomodoroActive) {
            cell.pomodoroView.isHidden = true
            
        } else {
            cell.pomodoroView.isHidden = false             
            }
        
        // pomodoro session
        cell.sessions.text = task.session
        
        return cell
    }
    
}
