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
    @IBOutlet weak var favoriteButton: UFCFighterFavoriteButton!
    @IBOutlet var LabelsToTranslate: [UILabel]!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FavoriteFighterClient.containsId(fighterId: fighter.id!){
            favoriteButton.imageView?.image = UIImage(named: "starOn")
            favoriteButton.isOn = true
        }
        updateUI()
    }
    
    @IBAction func linkButtonTapped(_ sender: UIButton!) {
        if let fighterLink = fighter.link {
        guard let url = URL(string: fighterLink) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func favoriteButtonTapped(_ sender: UFCFighterFavoriteButton) {
        if sender.isOn {
            FavoriteFighterClient.favoriteFighterId.append(fighter.id!)//USE ENUMS FOR ERRORS
            FavoriteFighterClient.saveIdToArray()
            print("Button is on")
        } else {
            FavoriteFighterClient.removeFighter(fighterId: fighter.id!)
            print("Button is off")
        }
            print(FavoriteFighterClient.retriveFighters())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? UFCFighterNewsViewController else {return}
        let fighter = self.fighter
        destination.fighter = fighter
    }
    func updateUI(){
        if let image = fighter.leftFullBodyImage{
        if let image = ImageHelper.shared.image(forKey: image as NSString) {
            fighterImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: fighter.leftFullBodyImage!) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.fighterImage.image = image
                }
            }
        }
        } else {
            fighterImage.image = UIImage(named: "fighterNil")
        }
        fighterLastName.text = fighter.lastName
        fighterFirstName.text = fighter.firstName
        fighterWeightClass.text = fighter.weightClass?.replacingOccurrences(of: "_", with: " ")
        fighterRank.text = "Rank: #\(fighter.rank ?? "Unranked")"
        fighterWins.text = "Wins: \(fighter.wins ?? 0)"
        fighterLosses.text = "Losses: \(fighter.losses ?? 0)"
        fighterDraws.text = "Draws: \(fighter.draws ?? 0)"
        fighterStatus.text = "Status: \(fighter.fighterStatus ?? "Unknown")"
        if LanguageClient.chosenLanguage == .spanish {
            if let weighClass = fighter.weightClass{
                fighterWeightClass.text = LanguageClient.translateToSpanish(word: weighClass)
                }
                fighterRank.text = "Rank: #\(fighter.rank ?? "No Ranking")"
                fighterWins.text = "Ganadas: \(fighter.wins ?? 0)"
                fighterLosses.text = "Perdidas: \(fighter.losses ?? 0)"
                fighterDraws.text = "Empates: \(fighter.draws ?? 0)"
                if let status = fighter.fighterStatus {
                fighterStatus.text = "Status: \(LanguageClient.translateToSpanish(word: status))"
                } else {
                    fighterStatus.text = "Status: Desconocido"
                }
            let wordsToTranslate = ["Favoritos", "Noticias", "Link"]
            for i in 0...LabelsToTranslate.count - 1{
                switch i{
                case 0...3:
                    LabelsToTranslate[i].text = wordsToTranslate[i]
                default:
                    print("Error Translating")
                }
            }
        
        }
    }

}
