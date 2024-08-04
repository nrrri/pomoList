import UIKit
import Foundation

var todoList = [TodoList]()

struct TodoList {
    var name: String?
    var description: String = ""
    var isPomodoroActive: Bool = true
    var session: String = "1"
    var remainSession: Int = 1
    var taskCompleted: Bool = false
    
    init(name: String, description: String, isActive: Bool, ss: String, rss: Int, isTaskComplete: Bool) {
        self.name = name
        self.description = description
        self.isPomodoroActive = isActive
        self.session = ss
        self.remainSession = rss
        self.taskCompleted = isTaskComplete
    }
}
