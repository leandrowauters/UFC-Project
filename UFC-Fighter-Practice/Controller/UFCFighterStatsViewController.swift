//
//  UFCFighterStatsViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/20/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit
import WebKit

class UFCFighterStatsViewController: UIViewController {
    var fighter: UFCFighter!
    
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        DispatchQueue.main.async {
            let url = URL(string:"http://ufc-data-api.ufc.com/api/v3/us/fighters/\(self.fighter.id!.description)")
            self.myWebView.load(URLRequest(url: url!))
            self.activityIndicator.stopAnimating()
        }
        }
}
