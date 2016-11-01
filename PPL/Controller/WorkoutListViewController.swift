//
//  WorkoutListViewController.swift
//  PPL
//
//  Created by Jovanny Espinal on 10/21/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class WorkoutListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var dataProvider: WorkoutListDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PPL"
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLoggingVC), name: Notification.Name("CurrentSessionTapped"), object: nil)
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
    
    
    @IBAction func removeAllWorkouts(_ sender: UIBarButtonItem) {
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
