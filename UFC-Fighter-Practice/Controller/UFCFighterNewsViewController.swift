//
//  UFCFighterNewsViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/16/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCFighterNewsViewController: UIViewController {
    
    @IBOutlet weak var fighterImage: UIImageView!
    @IBOutlet weak var fighterLastName: UILabel!
    @IBOutlet weak var fighterFirstName: UILabel!
    
    @IBOutlet weak var fighterTableView: UITableView!
    
    
    var fighter: UFCFighter!
    var articles = [UFCFighterArticle](){
        didSet{
            DispatchQueue.main.async {
                self.fighterTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UFCFighterNewsClient.getFighterNews(fighterId: fighter.id!.description){(article, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let article = article{
                    self.articles = article
                    dump(article)
                }
            }
        }
    }
    
    
}
