import UIKit
import Foundation

var todoList = [TodoList]()

struct TodoList {
    var name: String! // Do you really need this to be implicitly unwrapped? If you're thinking in terms of other languages, just remember that you don't need the "!" to say something is not nullable in Swift, just by not being Optional, something will necessarily not be nullable.
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
