//
//  WorkoutViewController.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/4/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dataProvider: WorkoutDataProvider!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        tableView.alwaysBounceVertical = false
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
