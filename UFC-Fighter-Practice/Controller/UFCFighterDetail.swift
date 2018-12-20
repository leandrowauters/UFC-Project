//
//  UFCFighterDetail.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/12/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCFighterDetail: UIViewController {

    var fighter: UFCFighter!
    

    @IBOutlet weak var fighterLastName: UILabel!
    @IBOutlet weak var fighterFirstName: UILabel!
    @IBOutlet weak var fighterWeightClass: UILabel!
    @IBOutlet weak var fighterWins: UILabel!
    @IBOutlet weak var fighterLosses: UILabel!
    @IBOutlet weak var fighterDraws: UILabel!
    @IBOutlet weak var fighterStatus: UILabel!
    
    @IBOutlet weak var fighterImage: UIImageView!
    @IBOutlet weak var fighterRank: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UFCFighterFavoriteButton) {
        if sender.isOn {
            print("Button is on")
        } else {
            print("Button is off")
        }
//        UFCData.favoriteFighterId.append(fighter.id!)
//        UFCData.saveIdToArray(fighterId: String(fighter.id!))
//        print(UFCData.retrieveArray(fighterId: String(fighter.id!)))
//        UFCData.printAllDefaults()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UFCFighterNewsViewController else {return}
        let fighter = self.fighter
        destination.fighter = fighter
    }
    func updateUI(){
        if let fighterPhoto = fighter.leftFullBodyImage{
            if let image = ImageClient.getImage(stringURL: fighterPhoto){
                fighterImage.image = image
            }
        } else {
            fighterImage.contentMode = .scaleToFill
            fighterImage.image = UIImage(named: "fighterNil")
            
        }
        fighterLastName.text = fighter.lastName
        fighterFirstName.text = fighter.firstName
        fighterWeightClass.text = fighter.weightClass?.replacingOccurrences(of: "_", with: " ")
        fighterRank.text = "Rank: #\(fighter.poundForPoundRank ?? "Unknown")"
        fighterWins.text = "Wins: \(fighter.wins ?? 0)"
        fighterLosses.text = "Losses: \(fighter.losses ?? 0)"
        fighterDraws.text = "Draws: \(fighter.draws ?? 0)"
        fighterStatus.text = "Status: \(fighter.fighterStatus ?? "Unknown")"
        
        
    }

}
