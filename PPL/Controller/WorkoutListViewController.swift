//
//  WorkoutListViewController.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class WorkoutListViewController: UIViewController, SettingsViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var dataProvider: WorkoutListDataProvider!
    lazy var slideInTransitioningDelegate = SlideinPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PPL"
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoggingVC), name: Notification.Name("CurrentSessionTapped"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showPastWorkoutVC), name: Notification.Name("PastSessionTapped"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPathRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPathRow, animated: false)
        }
        tableView.reloadData()
    }
    
    @IBAction func addWorkout(_ sender: UIBarButtonItem) {
        showLoggingVC()
    }
    
    func showLoggingVC() {
        if let loggingViewController = storyboard?.instantiateViewController(withIdentifier: "LoggingViewController") as? LoggingViewController {
            navigationController?.pushViewController(loggingViewController, animated: true)
        }
    }
    
    func showPastWorkoutVC(sender: Notification) {
        guard let senderIndex = sender.userInfo?["index"] as? Int, let dateString = sender.userInfo?["date"] as? String else { return }
        
        if let workoutVC = storyboard?.instantiateViewController(withIdentifier: "PastWorkoutViewController") as? WorkoutViewController {
            let dataProvider = WorkoutDataProvider()
            dataProvider.index = senderIndex
            workoutVC.dataProvider = dataProvider
            workoutVC.date = dateString
            navigationController?.pushViewController(workoutVC, animated: true)
        }
    }
    
    func clearWorkoutHistory() {
        let alertController = UIAlertController(title: "Clear Workout History", message: "Are you sure you want to clear your workout history? Everything will be reset to default settings.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let saveAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
            WorkoutManager.manager.removeAllWorkouts()
            UserDefaults.standard.removeObject(forKey: "PastWorkouts")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true)
        
    }
    
    func switchWeightFormat() {
        if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
            UserDefaults.standard.set(false, forKey: "metricIsKilograms")
        } else {
            UserDefaults.standard.set(true, forKey: "metricIsKilograms")
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SettingsViewController {
            if segue.identifier == "Settings" {
                slideInTransitioningDelegate.direction = .left
                
            }
            controller.settingsViewDelegate = self
            controller.transitioningDelegate = slideInTransitioningDelegate
            controller.modalPresentationStyle = .custom
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
