import UIKit
import Foundation

var todoList = [TodoList]()

struct TodoList {
    var id: UUID
    var name: String?
    var description: String = ""
    var isPomodoroActive: Bool = true
    var session: String = "1"
    var remainSession: Int = 1
    var isTaskComplete: Bool = false
    
    init(id: UUID, name: String? = nil, description: String, isPomodoroActive: Bool, session: String, remainSession: Int, isTaskComplete: Bool) {
        self.id = id
        self.name = name
        self.description = description
        self.isPomodoroActive = isPomodoroActive
        self.session = session
        self.remainSession = remainSession
        self.isTaskComplete = isTaskComplete
    }
}
