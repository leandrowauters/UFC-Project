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
    @IBOutlet weak var fighterClass: UILabel!
    @IBOutlet weak var fighterTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var fighter: UFCFighter!
    var articles = [UFCFighterArticle](){
        didSet{
            
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.fighterTableView.reloadData()
                self.activityIndicator.stopAnimating()
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
                    self.activityIndicator.stopAnimating()
                    self.articles = article
                }
            }
        }
    }

    func updateUI(){
//        if let imageUrl = fighter.thumbnail{
//            if let image = ImageClient.getImage(stringURL: imageUrl){
//                fighterImage.image = image
//            }
//        }
        if let image = ImageHelper.shared.image(forKey: fighter.thumbnail! as NSString) {
            fighterImage.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: fighter.thumbnail!) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    self.fighterImage.image = image
                }
            }
        }
        fighterLastName.text = fighter.lastName
        fighterFirstName.text = fighter.firstName
        fighterClass.text = fighter.weightClass
    }
    
}
extension UFCFighterNewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleToSet = articles[indexPath.row]
        let cell = fighterTableView.dequeueReusableCell(withIdentifier: "fighterNewsCell", for: indexPath)
        ColorClient.changeCellColor(indexPathRow: indexPath.row, cell: cell)
        cell.textLabel?.text = articleToSet.title
        cell.detailTextLabel?.text = DateClient.convertDateToLocalDate(str: articleToSet.articleDate, dateFormat: "MMM d, h:mm a")
//        let imageURL = articleToSet.thumbnail
//        if let image = ImageClient.getImage(stringURL: imageURL){
//            cell.imageView?.image = image
//        }
        if let image = ImageHelper.shared.image(forKey: articleToSet.thumbnail as NSString) {
            cell.imageView?.image = image
        } else {
            ImageHelper.shared.fetchImage(urlString: articleToSet.thumbnail) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    cell.imageView?.image = image
                }
            }
        }
        return cell
    }
}

extension UFCFighterNewsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = "http://ufc-data-api.ufc.com/api/v3/iphone/news/\(articles[indexPath.row].id)"
        guard let url = URL(string: article) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
