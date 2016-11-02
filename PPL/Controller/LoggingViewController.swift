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
    var timer: Timer?
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(showWCVC), name: Notification.Name("ChangeWeightButtonTapped"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(startTimer), name: Notification.Name("SetButtonTapped"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        timerContainer.isHidden = true
    }
    
    @IBAction func saveWorkout(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Save Workout", message: "Are you finished with your workout?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
            WorkoutManager.manager.add(WorkoutManager.manager.currentWorkout!)
            
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
            count = 0
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(incrementCount), userInfo: nil, repeats: true)
        
        let date: Date
        
        if index == 0 {
            date = Date(timeIntervalSinceNow: 180)
            timerDescriptionLabel.text = "Rest for 3 min. If you need more time, rest for 5 min."
        } else {
            date = Date(timeIntervalSinceNow: 60)
            timerDescriptionLabel.text = "Rest for 1 min. If you need more time rest for 3 min."
        }
        
        delegate?.scheduleNotification(at: date)
    }
    
    @IBAction func closeTimer() {
        timerContainer.isHidden = true
        timer!.invalidate()
    }
    
    func configureTimeLabel() {
        let minutes = count / 60
        let seconds = count % 60
        
        timerLabel.text = String(format: "%d:%02d", minutes, seconds)
    }
    
    func incrementCount(stopAt seconds: Int) {
        count += 1
        configureTimeLabel()
        
        if count == 60 || count == 180 || count == 300 {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
        }
        
        if count == 300 {
            timer!.invalidate()
            count = 0
            closeTimer()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


