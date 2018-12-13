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
    
    var event = [UFCEvent](){
        didSet{
            DispatchQueue.main.async {
                self.eventTableView.reloadData()
            }
        }
    }
    
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.dataSource = self
        UFCEventClinet.getEvent{(event, error) in
            if let error = error {
                print(error)
            }
            if let event = event {
                self.event = event
                print(self.event.count)
            }
        }
        
    }
    
    func getDates(event: UFCEvent) -> String {
        let date = event.event_date.components(separatedBy: "T")
        return date[0]
    }
}
extension UFCEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let eventToSet = event[indexPath.row]
        cell.textLabel?.text = "\(eventToSet.base_title): \(eventToSet.title_tag_line)"
        let date = getDates(event: eventToSet)
        cell.detailTextLabel?.text = date
        
        
        let imageURL = eventToSet.feature_image
        if let image = ImageClient.getImage(stringURL: imageURL){
            cell.imageView?.image = image
        }
        
        return cell
    }
    
    
}
