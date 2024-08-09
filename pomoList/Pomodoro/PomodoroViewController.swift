//
//  PomodoroViewController.swift
//  pomoList
//
//  Created by Narissorn Chowarun on 2024-06-15.
//

import UIKit

protocol PomodoroViewControllerDelegate: AnyObject {
    func updateSessions(for taskID: UUID, remainingSessions: Int, checkComplete: Bool)
}

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
    var pomodoroID: UUID?
    var pomodoroTitle: String? = ""
    var totalSessions: String = ""
    var r_sessions: Int = 0
    
    // Timer
    var setTimer: Timer?
    // set to number * 60 for real time
    let pomodoroTime = 45 // 45 * 60
    var totalTime = 45 // 45 * 60
    var breakTime = 15 // 15 * 60
    var isPomodoro = true
    var isTimerRunning = false
    
    weak var delegate: PomodoroViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set pomodoro label
        titleName.text = pomodoroTitle?.uppercased()
        
        // set remaining
       
           print("remaining: \(r_sessions)")
           sessions.text = "\(r_sessions)/\(totalSessions)"
        
        
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
                    var checkComplete = false
                    updateRemainSession()
                    
                    if r_sessions != 0 {
                        // show alert
                        showAlert(message: "Click play to continue next session")
                        // start new session
                        isTimerRunning = true
                        updatePlayPauseButtonWithSymbol()
                    } else {
                        print("your task: \(pomodoroTitle ?? "") is done!")
                        checkComplete = true
                        startPomodoro.isHidden = true
                        breakTimeLabel.isHidden = false
                        breakTimeLabel.text = "YOUR SESSION IS DONE"
                    }
                    
                    if let taskID = pomodoroID {
                        delegate?.updateSessions(for: taskID, remainingSessions: r_sessions, checkComplete: checkComplete)
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
        r_sessions -= 1
        sessions.text = "\(r_sessions)/\(totalSessions)"
    }
    
    func updatePlayPauseButtonWithSymbol() {
        let symbolName = isTimerRunning ? "play.fill" : "pause.fill"
        startPomodoro.setImage(UIImage(systemName: symbolName), for: .normal)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Session: \(r_sessions) Completed", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
