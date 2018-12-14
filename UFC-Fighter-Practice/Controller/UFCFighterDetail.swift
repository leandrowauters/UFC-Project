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
    @IBOutlet weak var fighterBackgroundImage: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        //FOR BACKGORUNG
    }
    
    func updateUI(){
        if let backgroundImageUrl = fighter.left_full_body_image{
            if let image = ImageClient.getImage(stringURL: backgroundImageUrl){
                fighterBackgroundImage.image = image
            }
        }
        fighterLastName.text = fighter.last_name
        fighterFirstName.text = fighter.first_name
        fighterWeightClass.text = fighter.weight_class?.replacingOccurrences(of: "_", with: " ")
        fighterWins.text = fighter.wins?.description
        fighterLosses.text = fighter.losses?.description
        fighterDraws.text = fighter.draws?.description
        fighterStatus.text = fighter.fighter_status
        
        
    }

}
