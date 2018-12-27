//
//  UFCEventDetailsViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/23/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCEventDetailsViewController: UIViewController {

    var event: UFCEvent!
    var eventDetails = [UFCEventDetails](){
        didSet{
            DispatchQueue.main.async{
                self.eventDetailsTableview.reloadData()
            }
        }
    }
    @IBOutlet weak var eventDetailsTableview: UITableView!
    
    @IBOutlet weak var image: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDetailsTableview.dataSource = self
        eventDetailsTableview.delegate = self
        getImage()
        getEventDetails()
    }
    
    func getEventDetails() {
        UFCEventDetailsClient.getEventDetails(eventId: event.id.description){(eventDetails, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let eventDetails = eventDetails{
                    self.eventDetails = eventDetails
                }
            }
        }
    }
        func getFighterFromId (fighterId: String) -> UFCFighter {
            var fighterToReturn: UFCFighter!
            for fighter in FavoriteFighterClient.everyFighter{
                if let id = fighter.id{
                    if String(id) == fighterId{
                        fighterToReturn = fighter
                }
            
            }
            
        }
        return fighterToReturn
    }

    func getImage(){
        let imageURL = event.featureImage
        if let image = ImageClient.getImage(stringURL: imageURL){
        self.image.image = image
        }
    }
}

extension UFCEventDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventToSet = eventDetails[indexPath.row]
        let fighter1 = getFighterFromId(fighterId: eventToSet.fighter1Id.description)
        let fighter2 = getFighterFromId(fighterId: eventToSet.fighter2Id.description)
        guard let cell = eventDetailsTableview.dequeueReusableCell(withIdentifier: "fightCell", for: indexPath) as? UFCEventDetailCell else {return UITableViewCell()}
        ColorClient.changeCellColor(indexPathRow: indexPath.row, cell: cell)
        cell.fighter1Name.text = "\(fighter1.lastName ?? "NO NAME"), \(fighter1.firstName)"
        cell.fighter1Record.text = eventToSet.fighter1record
        cell.fighter1Weight.text = fighter1.weightClass?.replacingOccurrences(of: "_", with: " ")
        if let imageURL = fighter1.profileImage{
        let image = ImageClient.getImage(stringURL: imageURL)
        cell.fighter1Image.image = image
        }
        cell.fighter2Name.text = "\(fighter2.lastName ?? "NO NAME"), \(fighter2.firstName)"
        cell.fighter2Record.text = eventToSet.fighter2record
        cell.fighter2Weight.text = fighter2.weightClass?.replacingOccurrences(of: "_", with: " ")
        if let imageURL = fighter2.profileImage{
            let image = ImageClient.getImage(stringURL: imageURL)
            cell.fighter2Image.image = image
        }
        if let winner1 = eventToSet.fighter1IsWinner,
        let winner2 = eventToSet.fighter2IsWinner,
        let result = eventToSet.result,
        let method = result.Method{
            cell.fighter1Image.alpha = winner1 ? 1 : 0.5
            cell.fighter2Image.alpha = winner2 ? 1 : 0.5
            cell.fighter1MethodLabel.text = winner1 ? "" : method
            cell.fighter2MethodLabel.text = winner2 ? "" : method
            
        } else {
            cell.fighter1Image.alpha = 1
            cell.fighter1Image.alpha = 1
            cell.fighter1MethodLabel.isHidden = true
            cell.fighter2MethodLabel.isHidden = true
        }
        
        return cell
    }
}
extension UFCEventDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
}
