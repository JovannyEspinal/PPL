//
//  SettingsViewController.swift
//  PPL
//
//  Created by Jovanny Espinal on 11/3/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate {
    func clearWorkoutHistory()
    func switchWeightFormat()
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var switchMetricCell: UITableViewCell!
    @IBOutlet weak var tableView: UITableView!
    var settingsViewDelegate: SettingsViewDelegate?
    lazy var pplURL: URL? = {
        let pplURLString = "https://www.reddit.com/r/Fitness/comments/37ylk5/a_linear_progression_based_ppl_program_for/"
        
        guard let url = URL.init(string: pplURLString) else {
            return nil
        }
        
        return url
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "About PPL"
        case 1:
            if let isKilograms = UserDefaults.standard.value(forKey: "metricIsKilograms") as? Bool, isKilograms == true {
                cell.textLabel?.text = "Switch to Pounds"
            } else {
                cell.textLabel?.text = "Switch to Kilograms"
            }
        case 2:
            cell.textLabel?.text = "Clear Workout History"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            if let url = pplURL {
                UIApplication.shared.open(url, options: [:])
            }
        case 1:
            self.settingsViewDelegate?.switchWeightFormat()
            self.dismiss(animated: true)
        case 2:
            self.dismiss(animated: true)
            self.settingsViewDelegate?.clearWorkoutHistory()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
