import UIKit
import Foundation

var todoList = [TodoList]()

var count: Int = 0

struct TodoList {
    var name: String!
    var description: String = ""
    var isPomodoroActive: Bool = true
    var session: String = "1"
    
    init(name: String, description: String, isActive: Bool, ss: String) {
        self.name = name
        self.description = description
        self.isPomodoroActive = isActive
        self.session = ss
    }
}

//struct TodoList {
//    // info
//    var taskName:String
//    var description:String
//    
//    // pomodoro
//    var isPomodoroActive: Bool
//    var session: String
//    
//    init(taskName: String, description: String, isActive: Bool, session: String) {
//        self.taskName = taskName
//        self.description = description
//        self.isPomodoroActive = isActive
//        self.session = session
//    }
//
//}
