//
//  EventViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/12/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCEventViewController: UIViewController {

    @IBOutlet weak var eventTableView: UITableView!
    
    var event = [UFCEvent]()
    
       
    override func viewDidLoad() {
        super.viewDidLoad()
        UFCEventClinet.getEvent{(event, error) in
            if let error = error {
                print(error)
            }
            if let event = event {
                self.event = event
            }
        }
        print(event.count)
    }
    

}
