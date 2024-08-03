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
    var pomodoroTitle: String? = ""
    var pomodoroSessions: String = ""
    var remainSession: Int = 0
    
    // Timer
    var setTimer: Timer?
    let pomodoroTime = 5
    var totalTime = 5 //45 * 60
    var breakTime = 3
    var isPomodoro = true
    var isTimerRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set pomodoro label
        titleName.text = pomodoroTitle?.uppercased()
        
        // set remaining
       if let remaining = Int(pomodoroSessions) {
           remainSession = remaining
           print("remaining: \(remainSession)")
           sessions.text = "\(remainSession)/\(pomodoroSessions)"
        }
        
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
            if totalTime == pomodoroTime || totalTime == 0 {
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
        startTimer(duration: pomodoroTime) // test
    }
    
    func startBreakTimer() {
        breakTimeLabel.text = "BREAK TIME"
        breakTimeLabel.isHidden = false
        isPomodoro = false
        startTimer(duration: breakTime+1) // +1 to show full duration in UI
        
    }
    
    func startTimer(duration: Int) {
        setTimer?.invalidate() // Invalidate any existing timer
        totalTime = duration
        setTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
            if totalTime > 0 {
                totalTime -= 1
                updateTimerLabel()
            } else {
                setTimer?.invalidate()
                isTimerRunning = false
                if isPomodoro {
                    startBreakTimer()
                } else {
                    // check remain session
                    updateRemainSession()
                    if remainSession != 0 {
                        // show alert
                        showAlert(message: "Click play to continue next session")
                        // start new session
                        isTimerRunning = true
                        updatePlayPauseButtonWithSymbol()
                    } else {
                        print("your task: \(pomodoroSessions) is done!")
                        startPomodoro.isHidden = true
                        breakTimeLabel.isHidden = false
                        breakTimeLabel.text = "YOUR SESSION IS DONE"
                        // delete/unactivate task using protocol
                    }
                }
            }
    }
    
    func updateTimerLabel() {
        let minutes = totalTime / 60
        let seconds = totalTime % 60
        timer.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    func updateRemainSession() {
        remainSession -= 1
        sessions.text = "\(remainSession)/\(pomodoroSessions)"
    }
    
    func updatePlayPauseButtonWithSymbol() {
        let symbolName = isTimerRunning ? "play.fill" : "pause.fill"
        startPomodoro.setImage(UIImage(systemName: symbolName), for: .normal)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Session: \(remainSession) Completed", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
