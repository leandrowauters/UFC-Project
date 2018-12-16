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
    
    var events = [UFCEvent](){
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
                self.events = event
            }
        }
    }
    

}
extension UFCEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        let eventToSet = events[indexPath.row]
        cell.textLabel?.text = "\(eventToSet.baseTitle): \(eventToSet.titleTagLine ?? "NO TITLE")"
        let date = DateClient.convertDateToLocalDate(str: eventToSet.eventDategmt, dateFormat: "MMM d, h:mm a")
        cell.detailTextLabel?.text = date
        let imageURL = eventToSet.featureImage
        if let image = ImageClient.getImage(stringURL: imageURL){
            cell.imageView?.image = image
        }
        return cell
    }
    
    
}
