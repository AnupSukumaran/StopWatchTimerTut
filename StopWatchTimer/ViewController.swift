//
//  ViewController.swift
//  StopWatchTimer
//
//  Created by Sukumar Anup Sukumaran on 18/10/18.
//  Copyright © 2018 TechTonic. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
   // var resumeTapped = false
    
    var seconds = 10 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var tempSec = 0
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

    override func viewDidLoad() {
        super.viewDidLoad()
         timerLabel.text = timeString(time: TimeInterval(seconds))
         tempSec = seconds
    }
    
    //MARK: Setting Timmer
    func runTimer(isPaused: Bool) {
        if isPaused  {
            print("timerIsStopped😩")
            timer.invalidate()
            isTimerRunning = false
        } else {
            print("timerIsRunning")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            isTimerRunning = true
        }
        
    }
    
    //MARK: func used for Timer
   @objc func updateTimer() {
    print("Running.. = \(tempSec)😄")
   
    
    if tempSec < 1 {
      //  print("timer is zero😄")
        runTimer(isPaused: true)
        print("Times Up!😄")
        tempSec = seconds
    } else {
       // print("normal function😄")
        tempSec -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = timeString(time: TimeInterval(tempSec))
        print("tempec = \(tempSec)")
        if tempSec < 6 {
            timerLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            AudioServicesPlaySystemSound(SystemSoundID(1001))
        }
        
    }
    
    
    
    }
    
    //MARK: func setting timer formate
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func startAction(_ sender: Any) {
        if isTimerRunning == false {
            runTimer(isPaused: false)
        }
        
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        runTimer(isPaused: true)
    }
    
    @IBAction func resetAction(_ sender: Any) {
        runTimer(isPaused: true)
        tempSec = seconds
        timerLabel.text = timeString(time: TimeInterval(seconds))
        timerLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}

