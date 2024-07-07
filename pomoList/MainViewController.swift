//
//  ViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-14.
//

import UIKit

class MainViewController: UIViewController {
    
    let tasks = [
        Task(taskName: "Study Math", date: Date(), time: "10:00 AM", description: "sdfgnkdlsagnl", pomodoro: Pomodoro(isActive: true, session: "1")),
        Task(taskName: "Working on Final project", date: Date(), time: "4:00 PM", description: "df,gnad;flkhnfape;dlhna;hgb", pomodoro: Pomodoro(isActive: true, session: "2")),
        Task(taskName: "Reading book", date: Date(), time: "8:00 PM", description: "dksghldksa;gkdnsa;gkhdsa;gnkds;a", pomodoro: Pomodoro(isActive: false, session: ""))
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        
        setTableView()
    }
    
    func setTableView() {
        tableView.frame = view.bounds
        tableView.rowHeight = 124
        tableView.contentInsetAdjustmentBehavior = .never
    }

}



extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "task card", for: indexPath) as! TaskCardTableViewCell
        
        let task = tasks[indexPath.section]
        cell.layer.cornerRadius = 16
        
        
        cell.title.text = task.taskName
        cell.time.text = task.time
        
        cell.time.backgroundColor = UIColor(red: RGBGray100.red.value, green: RGBGray100.green.value, blue: RGBGray100.blue.value, alpha: 1.0)
        cell.time.layer.masksToBounds = true;
        cell.time.layer.cornerRadius = 6;
        
        cell.detail.text = task.description
        
        if task.pomodoro.isActive == false {
            cell.pomodoroView.isHidden = true
            cell.sessions.text = task.pomodoro.session
            
            cell.tappedBtn = {[unowned self] in
                let story = UIStoryboard(name: "Main", bundle: nil)
                let controller = story.instantiateViewController(identifier: "PomodoroViewController") as! PomodoroViewController
                self.present(controller, animated: true, completion: nil)
                
            }
        }
        
        return cell
    }
    
}
