//
//  UFCFighterFavoriteButton.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/19/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCFighterFavoriteButton: UIButton {

    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    func initButton(){
        addTarget(self, action: #selector(UFCFighterFavoriteButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        isOn = bool
        let image = bool ? UIImage(named: "starOn") : UIImage(named: "starOff")
        setImage(image, for: .normal)
    }
}
