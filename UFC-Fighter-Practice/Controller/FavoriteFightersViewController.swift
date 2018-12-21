//
//  favoriteFighterViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/20/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class FavoriteFightersViewController: UIViewController {
    
var favorites = [UFCFighter]() {
        didSet{
            DispatchQueue.main.async {
                self.favoriteTableView.reloadData()
            }
        }
    }
    @IBOutlet weak var favoriteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.dataSource = self
        favorites = FavoriteFighterClient.getFightersFromId(fighterIds: FavoriteFighterClient.retriveFighters(), fighters: FavoriteFighterClient.everyFighter)
    }
    override func viewWillAppear(_ animated: Bool) {
                favorites = FavoriteFighterClient.getFightersFromId(fighterIds: FavoriteFighterClient.retriveFighters(), fighters: FavoriteFighterClient.everyFighter)
    }
}

extension FavoriteFightersViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fighterToSet = favorites[indexPath.row]
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "favoriteFighterCell", for: indexPath)
        cell.textLabel?.text = fighterToSet.lastName
        return cell
    }
}
