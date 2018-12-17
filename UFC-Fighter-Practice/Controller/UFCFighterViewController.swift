//
//  ViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/10/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class UFCFighterViewController: UIViewController {
  
    
    @IBOutlet var filterByButtons: [UIButton]!
    @IBOutlet weak var fighterActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var fighterSearchBar: UISearchBar!
    
    @IBOutlet weak var fighterTableView: UITableView!
    
    var buttonTaps = 1
    var fighters = [UFCFighter]() {
        didSet{
            DispatchQueue.main.async {
                self.fighterActivityIndicator.startAnimating()
                
                self.fighterTableView.reloadData()
                self.fighterActivityIndicator.stopAnimating()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fighterActivityIndicator.startAnimating()
        fighterTableView.tableFooterView = UIView()
        fighterSearchBar.delegate = self
        fighterTableView.dataSource = self
        UFCFighterClient.getFighter {(fighters, error) in // REPEATS SO  MAKE IT ITO FUNC
            DispatchQueue.main.async {
            self.fighterActivityIndicator.stopAnimating()
            if let error = error {
                print(error)
            }
            if let fighters = fighters {
                
              self.fighters = fighters
            }
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = fighterTableView.indexPathForSelectedRow,
            let ufcFighterDetail = segue.destination as? UFCFighterDetail else {
                return
        }
        let fighter = fighters[indexPath.row]
        ufcFighterDetail.fighter = fighter
    }
    
    func searchFighter (keyword: String){
        UFCFighterClient.getFighter{fighter, error in
            if let fighterResult = fighter{
                var fighterWithLastNames = [UFCFighter]()
                fighterResult.forEach{$0.lastName != nil ? fighterWithLastNames.append($0) : print("notingh")}
                self.fighters = fighterWithLastNames.filter{$0.firstName.lowercased().contains(keyword.lowercased())||(($0.lastName?.lowercased().contains(keyword.lowercased()))!)}
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
            DispatchQueue.main.async {
                self.buttonTaps += 1
                if self.buttonTaps % 2 == 0 {
                    var fighterLastName = [UFCFighter]()
                    self.fighters.forEach{$0.lastName != nil ? fighterLastName.append($0) : print("nothing")}
                    self.fighters = fighterLastName.sorted{$0.lastName!.capitalized < $1.lastName!.capitalized}
            } else {
                    self.fighters = self.fighters.reversed()
            }
            }
        case 1:
            DispatchQueue.main.async {
                self.buttonTaps += 1
                if self.buttonTaps % 2 == 0 {
                var fighterWeight = [UFCFighter]()
                    self.fighters.forEach{$0.weightClass != nil ? fighterWeight.append($0) : print("nothing")}
                    self.fighters = fighterWeight.sorted{$0.weightClass! < $1.weightClass!}
            } else {
                    self.fighters = self.fighters.reversed()
                }
        }
        case 2:
            DispatchQueue.main.async{
                self.buttonTaps += 1
                if self.buttonTaps % 2 == 0 {
                var fighterWins = [UFCFighter]()
                    self.fighters.forEach{$0.wins != nil ? fighterWins.append($0) : print("nothing")}
                    self.fighters = fighterWins.sorted{$0.wins! < $1.wins!}
            } else {
                    self.fighters = self.fighters.reversed()
            }
            }
        case 3:
            DispatchQueue.main.async{
                self.buttonTaps += 1
                if self.buttonTaps % 2 == 0 {
                var fighterLosses = [UFCFighter]()
                    self.fighters.forEach{$0.losses != nil ? fighterLosses.append($0) : print("nothing")}
                    self.fighters = fighterLosses.sorted{$0.losses! < $1.losses!}
            } else {
                    self.fighters = self.fighters.reversed()
            }
            }
        case 4:
            DispatchQueue.main.async{
                self.buttonTaps += 1
                if self.buttonTaps % 2 == 0 {
                var fighterDraws = [UFCFighter]()
                    self.fighters.forEach{$0.draws != nil ? fighterDraws.append($0) : print("nothing")}
                    self.fighters = fighterDraws.sorted{$0.draws! < $1.draws!}
            } else {
                    self.fighters = self.fighters.reversed()
            }
            }
        case 5:
            DispatchQueue.main.async{
                self.buttonTaps += 1
                if self.buttonTaps % 2 == 0 {
                var fighterStatus = [UFCFighter]()
                    self.fighters.forEach{$0.fighterStatus != nil ? fighterStatus.append($0) : print("nothing") }
            } else {
                self.fighters = self.fighters.reversed()
            }
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

extension UFCFighterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fighters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fighterTableView.dequeueReusableCell(withIdentifier: "fighterCell", for: indexPath)
        let fighterToSet = fighters[indexPath.row]
        ColorClient.changeCellColor(indexPathRow: indexPath.row, cell: cell)
        cell.textLabel?.text = "\(fighterToSet.lastName ?? "No Name"), \(fighterToSet.firstName)" 
        cell.detailTextLabel?.text = fighterToSet.weightClass?.replacingOccurrences(of: "_", with: " ")
        if let imageUrl = fighterToSet.thumbnail {
            if let image = ImageClient.getImage(stringURL: imageUrl){
                cell.imageView?.image = image
            }
        }
        return cell
    }
    
    
}
extension UFCFighterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async{
        self.searchFighter(keyword: searchText)
        if searchBar.text!.isEmpty{
            UFCFighterClient.getFighter {(fighters, error) in
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
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        DispatchQueue.main.async {
//            self.searchFighter(keyword: searchBar.text!)
//        }
//    }
}
