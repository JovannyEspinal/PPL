//
//  LoggingViewController.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/25/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AudioToolbox

class LoggingViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dataProvider: LoggingWorkoutDataProvider!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerContainer: UIView!
    @IBOutlet weak var timerDescriptionLabel: UILabel!
    var date: String?
    var timer: Timer?
    var start: CFAbsoluteTime!
    var elapsedTime: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(showWCVC), name: Notification.Name("ChangeWeightButtonTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: Notification.Name("SetButtonTapped"), object: nil)
        
        let restTimerButton = UIBarButtonItem(image: UIImage(named: "Stopwatch") , style: .plain, target: self, action: #selector(showRestTimer))
        self.navigationItem.rightBarButtonItem = restTimerButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        if let savedStartDate = UserDefaults.standard.object(forKey: "startDate") as? CFAbsoluteTime {
            start = savedStartDate
    
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(calculateTime), userInfo: nil, repeats: true)
            timerContainer.isHidden = false
        }else {
            timerContainer.isHidden = true
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    
    func showRestTimer() {
        guard elapsedTime > 0 else { return }
        
        timerContainer.isHidden = !timerContainer.isHidden
    }
    
    
    @IBAction func saveWorkout(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Save Workout", message: "Are you finished with your workout?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
            WorkoutManager.manager.add(WorkoutManager.manager.currentWorkout! |> Workout.dateLens *~ Date())
            
            let json = WorkoutManager.manager.toJSON()
            
            if let _ = UserDefaults.standard.object(forKey: "PastWorkouts") as? [String: Any] {
                UserDefaults.standard.removeObject(forKey: "PastWorkouts")
                UserDefaults.standard.set(json, forKey: "PastWorkouts")
            } else {
                UserDefaults.standard.set(json, forKey: "PastWorkouts")
            }
            
            DispatchQueue.main.async {
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    func showWCVC(sender: Notification) {
        
        UserDefaults.standard.set(start, forKey: "startDate")
        if let weightChangeViewController = storyboard?.instantiateViewController(withIdentifier: "WeightChangeViewController") as? WeightChangeViewController, let index = sender.userInfo?["index"] as? Int {
            
            weightChangeViewController.index = index
            
            present(weightChangeViewController, animated: true, completion: nil)
        }
    }
    
    func startTimer(sender: Notification) {
        guard let index = sender.userInfo?["index"] as? Int,
            let set = sender.userInfo?["set"] as? ExerciseSet,
            let reps = sender.userInfo?["numberOfRepsCompleted"] as? Int else { return }
        
        if reps == 0 && set.firstAttempt {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            closeTimer()
            return
        }
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        timerContainer.isHidden = false
        
        if timer != nil {
            timer!.invalidate()
            elapsedTime = 0
            start = 0
        }
        
        start = CFAbsoluteTimeGetCurrent()
        
        UserDefaults.standard.set(start, forKey: "startDate")
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(calculateTime), userInfo: nil, repeats: true)
        
        let seconds: TimeInterval
        
        if index == 0 {
            seconds = 180
            timerDescriptionLabel.text = "Rest for 3 min. If you need more time, rest for 5 min."
        } else {
            seconds = 60
            timerDescriptionLabel.text = "Rest for 1 min. If you need more time rest for 3 min."
        }
        
        delegate?.scheduleNotification(after: seconds)
    }
    
    @IBAction func closeTimer() {
        timerContainer.isHidden = true
        timer!.invalidate()
        timer = nil
        elapsedTime = 0
        UserDefaults.standard.removeObject(forKey: "startDate")
        UserDefaults.standard.synchronize()
        
    }
    
    func configureTimeLabel() {
        let minutes = Int(elapsedTime / 60)
        let seconds = Int(elapsedTime.truncatingRemainder(dividingBy: 60.0))
    
        timerLabel.text = String(format: "%d:%02d", minutes, seconds)
    }
    
    func calculateTime() {
        elapsedTime = CFAbsoluteTimeGetCurrent() - start
        
        configureTimeLabel()
        
        if elapsedTime == 60 || elapsedTime == 180 || elapsedTime == 300 {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        
        if elapsedTime == 300 {
            timer!.invalidate()
            closeTimer()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


