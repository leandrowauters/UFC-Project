//
//  UFCNewsViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/14/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCNewsViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    
    var news = [UFCNews](){
        didSet{
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        UFCNewsClient.getNews{(article, error) in
            if let error = error {
                print(error)
            }
            if let article = article {
                self.news = article
            }
            
        }
        
    }
    

}
extension UFCNewsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleToSet = news[indexPath.row]
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        ColorClient.changeCellColor(indexPathRow: indexPath.row, cell: cell)
        cell.textLabel?.text = articleToSet.title
        cell.detailTextLabel?.text = DateClient.convertDateToLocalDate(str: articleToSet.articleDate, dateFormat: "MMM d, yyyy")
        let imageURL = articleToSet.thumbnail
        if let image = ImageClient.getImage(stringURL: imageURL){
            cell.imageView?.image = image
        }
        return cell
    }
}

extension UFCNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = "http://ufc-data-api.ufc.com/api/v3/iphone/news/\(news[indexPath.row].id)"
        guard let url = URL(string: article) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
