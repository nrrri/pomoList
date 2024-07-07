import UIKit
import Foundation

class Task {
    // info
    var taskName:String
    var date:Date
    var time:String
    var description:String
    
    let pomodoro: Pomodoro
    
    init(taskName: String, date: Date, time: String, description: String, pomodoro: Pomodoro) {
        self.taskName = taskName
        self.date = date
        self.time = time
        self.description = description
        self.pomodoro = pomodoro
    }

}

class Pomodoro {
    var isActive: Bool
    var session: String
    
    init(isActive: Bool, session: String) {
        self.isActive = isActive
        self.session = session
    }
        
}
