//
//  PomodoroViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-15.
//

import UIKit

class PomodoroViewController: UIViewController {
    // Data from todolist
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var sessionView: UIView!
    @IBOutlet weak var sessions: UILabel!
    
    // Timer
    @IBOutlet weak var startPomodoro: UIButton!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    
    // Data
    var pomodoroTitle: String = "pomoTitle"
    var pomodoroSessions: String = "test"
    var remainSession: String = "test"
    
    var task: TodoList?
    
    // Timer
    var setTimer: Timer?
    var totalTime = 45 * 60
    var isPomodoro = true
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set pomodoro data
        pomodoroTitle = task?.name ?? "test"
        print("in pomodoro: \(pomodoroTitle)")
        
        remainSession = task?.session ?? "1"
        pomodoroSessions = task?.session ?? "1"
        
        // Set pomodoro label
        titleName.text = pomodoroTitle
        sessions.text = "\(remainSession)/\(pomodoroSessions)"
       
        // Set timer
        updateTimerLabel()
    }
    
    @IBAction func startPauseSession(_ sender: UIButton) {
        updatePlayPauseButtonWithSymbol()
        if isTimerRunning {
            pauseTimer()
        } else {
            startPomodoroOrResume()
        }
    }
    
    func startPomodoroOrResume() {
        if !isTimerRunning {
            if totalTime == 45 * 60 || totalTime == 0 {
                startPomodoroTimer()
            } else {
                resumeTimer()
            }
        }
    }
    
    func resumeTimer() {
        setTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    func pauseTimer() {
        setTimer?.invalidate()
        isTimerRunning = false
    }
    
    func startPomodoroTimer() {
        breakTimeLabel.isHidden = true
        isPomodoro = true
        startTimer(duration:  3) // test
//        startTimer(duration:  45 * 60) // 45 minutes
    }
    
    func startBreakTimer() {
        breakTimeLabel.isHidden = false
        isPomodoro = false
        startTimer(duration: 3) // test
//        startTimer(duration: 15 * 60) // 15 minutes
    }
    
    func startTimer(duration: Int) {
        setTimer?.invalidate() // Invalidate any existing timer
        totalTime = duration
        setTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        var timeRemaining = Int(remainSession) ?? 1
        while timeRemaining > 0 {
            timeRemaining -= 1
            
            if totalTime > 0 {
                totalTime -= 1
                updateTimerLabel()
            } else {
                setTimer?.invalidate()
                isTimerRunning = false
                if isPomodoro {
                    startBreakTimer()
                } else {
                    // show alert
                    print("continue next session?")
                }
            }
        }
        
            // show alert done task
            print("Goodjob! you just finish (title's name)!")
        
    }
    
    func updateTimerLabel() {
        let minutes = totalTime / 60
        let seconds = totalTime % 60
        timer.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updatePlayPauseButtonWithSymbol() {
        let symbolName = isTimerRunning ? "play.fill" : "pause.fill"
        startPomodoro.setImage(UIImage(systemName: symbolName), for: .normal)
    }
}
