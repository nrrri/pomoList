import UIKit

public class TaskCard {
    // info
    static var taskName:String
    static var date:Date
    static var tags:[String]
    static var description:String
    
    init(taskName: String, date: Date, tags: [String], description: String) {
            self.taskName = taskName
            self.date = date
            self.tags = tags
            self.description = description
        }
    
    // pomodoro
    func isPomodoroOn(pomodoro: Pomodoro) -> Boolean {
        return Pomodoro // TBD
    }
}

class Pomodoro {
    static var session:Int
    
    init(session: Int) {
            self.session = session
        }
    
    func playPomodoro(session: session) -> s_left {
        var s_remain = session
        if s_remain > 0 {
            // play pomodoro
            s_done -= 1
        }
        return s_remain
        
    }
}
