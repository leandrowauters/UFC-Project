//
//  ViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/10/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    
    @IBOutlet var filterByButtons: [UIButton]!
    
    @IBOutlet weak var fighterSearchBar: UISearchBar!
    
    @IBOutlet weak var fighterTableView: UITableView!
    
    var buttonTaps = 1
    private var sortedFighters = [UFCFighter]()
    var fighters = [UFCFighter]() {
        didSet{
            DispatchQueue.main.async {
                self.fighterTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        fighterSearchBar.delegate = self
        super.viewDidLoad()
        fighterTableView.dataSource = self
        UFCAPIClient.getFighter {(fighters, error) in
            if let error = error {
                print(error)
            }
            if let fighters = fighters {
                self.fighters = fighters
            }
        }
        
    }

    
    func searchFighter (keyword: String){
        UFCAPIClient.getFighter{fighter, error in
            if let fighterResult = fighter{
                self.fighters = fighterResult
                self.fighters = fighterResult.filter{$0.first_name.lowercased().contains(keyword.lowercased())||$0.last_name.lowercased().contains(keyword.lowercased())}
            }
        }
        }

    @IBAction func dropDownPressed(_ sender: UIButton) {
        filterByButtons.forEach{(button) in
            UIView.animate(withDuration: 0.5, animations: {button.isHidden = !button.isHidden})
            self.view.layoutIfNeeded()
        }
        
    }
    @IBAction func filterByWasTapped(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            buttonTaps += 1
            if buttonTaps % 2 == 0 {
                fighters = fighters.sorted{$0.last_name.capitalized < $1.last_name.capitalized}
            } else {
                fighters = fighters.reversed()
            }
        
        case 1:
            buttonTaps += 1
            if buttonTaps % 2 == 0 {
                var fighterWeight = [UFCFighter]()
                fighters.forEach{$0.weight_class != nil ? fighterWeight.append($0) : print("nothing")}
                fighters = fighterWeight.sorted{$0.weight_class! < $1.weight_class!}
            } else {
                fighters = fighters.reversed()
        }
        case 2:
            buttonTaps += 1
            if buttonTaps % 2 == 0 {
                var fighterWins = [UFCFighter]()
                fighters.forEach{$0.wins != nil ? fighterWins.append($0) : print("nothing")}
                fighters = fighterWins.sorted{$0.wins! < $1.wins!}
            } else {
                fighters = fighters.reversed()
            }
        case 3:
            buttonTaps += 1
            if buttonTaps % 2 == 0 {
                var fighterLosses = [UFCFighter]()
                fighters.forEach{$0.losses != nil ? fighterLosses.append($0) : print("nothing")}
                fighters = fighterLosses.sorted{$0.losses! < $1.losses!}
            } else {
                fighters = fighters.reversed()
            }
        case 4:
            buttonTaps += 1
            if buttonTaps % 2 == 0 {
                var fighterDraws = [UFCFighter]()
                fighters.forEach{$0.draws != nil ? fighterDraws.append($0) : print("nothing")}
                fighters = fighterDraws.sorted{$0.draws! < $1.draws!}
            } else {
                fighters = fighters.reversed()
            }
        case 5:
            buttonTaps += 1
            if buttonTaps % 2 == 0 {
                fighters = fighters.sorted{$0.fighter_status < $1.fighter_status}
            } else {
                fighters = fighters.reversed()
            }

        default:
            print("error")
        }
        filterByButtons.forEach{(button) in
            UIView.animate(withDuration: 0.5, animations: {button.isHidden = !button.isHidden})
            self.view.layoutIfNeeded()
        
        }
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fighters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fighterTableView.dequeueReusableCell(withIdentifier: "fighterCell", for: indexPath)
        let fighterToSet = fighters[indexPath.row]
        cell.textLabel?.text = "\(fighterToSet.last_name), \(fighterToSet.first_name)"
        
        cell.detailTextLabel?.text = fighterToSet.weight_class?.replacingOccurrences(of: "_", with: " ")
        if let url = URL.init(string: fighterToSet.thumbnail!) { // create a function, see News Project
            do{
                let data = try Data.init(contentsOf: url)
                if let image = UIImage.init(data: data) {
                    cell.imageView?.image = image
                }
            } catch {
                print(error)
            }
        }
        return cell
    }
    
    
}
//MARK: TODO SEARCHBAR
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async{
        self.searchFighter(keyword: searchText)
        if searchBar.text!.isEmpty{
            UFCAPIClient.getFighter {(fighters, error) in
                if let error = error {
                    print(error)
                }
                if let fighters = fighters {
                    self.fighters = fighters
                }
            }
        }
    }
    }
}
