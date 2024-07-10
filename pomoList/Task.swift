import UIKit
import Foundation

var tasks = [TodoList]()

struct TodoList {
    // info
    var taskName:String
//    var date: Date
//    var time: String
    var description:String
    
    // pomodoro
    var isPomodoroActive: Bool
    var session: String
    
    init(taskName: String, description: String, isActive: Bool, session: String) {
        self.taskName = taskName
//        self.date = date
//        self.time = time
        self.description = description
        self.isPomodoroActive = isActive
        self.session = session
    }

}
