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
        fighterTableView.dataSource = self
        fighterTableView.delegate = self
        updateUI()
        UFCFighterNewsClient.getFighterNews(fighterId: fighter.id!.description){(article, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let article = article{
                    self.articles = article
                }
            }
        }
    }
    func updateUI(){
        if let imageUrl = fighter.thumbnail{
            if let image = ImageClient.getImage(stringURL: imageUrl){
                fighterImage.image = image
            }
        }
        fighterLastName.text = fighter.lastName
        fighterFirstName.text = fighter.firstName
    }
    
}
extension UFCFighterNewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleToSet = articles[indexPath.row]
        let cell = fighterTableView.dequeueReusableCell(withIdentifier: "fighterNewsCell", for: indexPath)
        cell.textLabel?.text = articleToSet.title
        cell.detailTextLabel?.text = DateClient.convertDateToLocalDate(str: articleToSet.articleDate, dateFormat: "MMM d, h:mm a")
        let imageURL = articleToSet.thumbnail
        if let image = ImageClient.getImage(stringURL: imageURL){
            cell.imageView?.image = image
        }
        return cell
    }
}

extension UFCFighterNewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
