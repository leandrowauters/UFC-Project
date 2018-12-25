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
        eventTableView.delegate = self
        UFCEventClinet.getEvent{(event, error) in
            if let error = error {
                print(error)
            }
            if let event = event {
                self.events = event
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = eventTableView.indexPathForSelectedRow,
            let ufcEventDetails = segue.destination as? UFCEventDetailsViewController else {
                return
        }
        let event = events[indexPath.row]
        ufcEventDetails.event = event
    }

}
extension UFCEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = eventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? UFCEventCell else {return UITableViewCell()}
        let eventToSet = events[indexPath.row]
        print(eventToSet.id)
        let date = DateClient.convertDateToLocalDate(str: eventToSet.eventDategmt, dateFormat: "MMM d, h:mm a")
        cell.eventName.text = eventToSet.baseTitle
        cell.eventSubtitle.text = eventToSet.titleTagLine
        cell.eventDate.text = "\(date)  \(eventToSet.arena) - \(eventToSet.location)"
        let imageURL = eventToSet.featureImage
        
        if eventToSet.featureImage == "" {
            let image = ImageClient.getImage(stringURL: ImageClient.defaultImageURL)
            cell.cellImage.image = image
        } else if let image = ImageClient.getImage(stringURL: imageURL){
            cell.cellImage.image = image
            
        }
        
        return cell
    }
    
    
}

extension UFCEventViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
