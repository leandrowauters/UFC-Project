//
//  MainScreenViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 1/4/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func languageButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            LanguageClient.chosenLanguage = .english
        case 1:
            LanguageClient.chosenLanguage = .spanish
        default:
            print("Language Not Chosen")
        }
    }
    


}
