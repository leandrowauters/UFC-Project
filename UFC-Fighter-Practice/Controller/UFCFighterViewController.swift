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
    @IBOutlet weak var sortByButton: UIButton!
    
    var buttonTaps = [1,1,1,1,1,1]
    var everyFighter = [UFCFighter]()
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
        
        FavoriteFighterClient.favoriteFighterId = FavoriteFighterClient.retriveFighters()
        fighterTableView.tableFooterView = UIView()
        fighterSearchBar.delegate = self
        fighterTableView.dataSource = self
        getFighters()
        print(LanguageClient.chosenLanguage)
        translateUIToSpanish()
        translateTabBarToSpanish()
        
        
    }
    func translateTabBarToSpanish(){
        if LanguageClient.chosenLanguage == .spanish{
            let wordsToTranslate = ["Peleadores","Eventos","Noticias", "Favoritos"]
        for i in 0...self.tabBarController!.tabBar.items!.count - 1{
            switch i {
            case 0...4:
                self.tabBarController?.tabBar.items?[i].title = wordsToTranslate[i]
            default:
                print("ERRor in tab")
            }
            }
        }
    }
    func translateUIToSpanish(){
        if LanguageClient.chosenLanguage == .spanish {
            let wordToTranslate = ["Nombre", "Categoria", "Ganadas", "Perdidas", "Empatadas"]
            sortByButton.setTitle("Ordenar", for: .normal)
            for button in filterByButtons {
                switch button.tag{
                case 0...4:
                    button.setTitle(wordToTranslate[button.tag], for: .normal)
                default:
                    print("Error")
                }
            }
            
        }
    }
    func getFighters() {
        UFCFighterClient.getFighter {(fighters, error) in // REPEATS SO  MAKE IT ITO FUNC
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let fighters = fighters {
                    let fighters = fighters.filter{$0.lastName != nil}
                    self.fighters = fighters
                    FavoriteFighterClient.everyFighter = fighters
                    self.everyFighter = fighters
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
                let fighters = fighterResult.filter{$0.lastName != nil}
                self.fighters = fighters.filter{$0.firstName.lowercased().contains(keyword.lowercased())||(($0.lastName?.lowercased().contains(keyword.lowercased()))!)}
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
        self.fighters = everyFighter
        switch sender.tag {
        case 0:
            DispatchQueue.main.async {
                var fighterLastName = [UFCFighter]()
                self.fighters.forEach{$0.lastName != nil ? fighterLastName.append($0) : print("nothing")}
                self.buttonTaps[sender.tag] += 1
                if self.buttonTaps[sender.tag] % 2 == 0 {
                    self.fighters = fighterLastName.sorted{$0.lastName!.capitalized < $1.lastName!.capitalized}
            } else {
                    self.fighters = fighterLastName.sorted{$0.lastName!.capitalized > $1.lastName!.capitalized}
            }
        }
        case 1:
            DispatchQueue.main.async {
                self.buttonTaps[sender.tag] += 1
                var fighterWeight = [UFCFighter]()
                self.fighters.forEach{$0.weightClass != nil ? fighterWeight.append($0) : print("nothing")}
                if self.buttonTaps[sender.tag] % 2 == 0 {
                    self.fighters = fighterWeight.sorted{$0.weightClass! < $1.weightClass!}
            } else {
                    self.fighters = fighterWeight.sorted{$0.weightClass! > $1.weightClass!}
                }
        }
        case 2:
            DispatchQueue.main.async{
                self.buttonTaps[sender.tag] += 1
                var fighterWins = [UFCFighter]()
                self.fighters.forEach{$0.wins != nil ? fighterWins.append($0) : print("nothing")}
                if self.buttonTaps[sender.tag] % 2 == 0 {
                    self.fighters = fighterWins.sorted{$0.wins! > $1.wins!}
            } else {
                    self.fighters = fighterWins.sorted{$0.wins! < $1.wins!}
            }
            }
        case 3:
            DispatchQueue.main.async{
                self.buttonTaps[sender.tag] += 1
                var fighterLosses = [UFCFighter]()
                self.fighters.forEach{$0.losses != nil ? fighterLosses.append($0) : print("nothing")}
                if self.buttonTaps[sender.tag] % 2 == 0 {
                    self.fighters = fighterLosses.sorted{$0.losses! < $1.losses!}
            } else {
                    self.fighters = fighterLosses.sorted{$0.losses! > $1.losses!}
            }
            }
        case 4:
            DispatchQueue.main.async{
                self.buttonTaps[sender.tag] += 1
                var fighterDraws = [UFCFighter]()
                self.fighters.forEach{$0.draws != nil ? fighterDraws.append($0) : print("nothing")}
                if self.buttonTaps[sender.tag] % 2 == 0 {
                    self.fighters = fighterDraws.sorted{$0.draws! < $1.draws!}
            } else {
                    self.fighters = fighterDraws.sorted{$0.draws! > $1.draws!}
            }
            }
//        case 5:
//            DispatchQueue.main.async{
//                let favorites = FavoriteFighterClient.getFightersFromId(fighterIds: FavoriteFighterClient.retriveFighters(), fighters: self.fighters)
//                self.buttonTaps[sender.tag] += 1
//                if self.buttonTaps[sender.tag] % 2 == 0 {
//                    self.fighters = favorites.sorted{$0.lastName!.capitalized < $1.lastName!.capitalized}
//                } else {
//                    self.fighters = self.fighters.reversed()
//                }
//        }
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
//        print("fighterID: \(UFCFighterClient.getFighterFromId(id: fighterToSet.id!))")
        ColorClient.changeCellColor(indexPathRow: indexPath.row, cell: cell)
        cell.textLabel?.text = "\(fighterToSet.lastName ?? "No Name"), \(fighterToSet.firstName)" 
        cell.detailTextLabel?.text = fighterToSet.weightClass?.replacingOccurrences(of: "_", with: " ")
        if LanguageClient.chosenLanguage == .spanish{
            if let weigthClass = fighterToSet.weightClass{
                let translateWord = LanguageClient.translateToSpanish(word: weigthClass)
                cell.detailTextLabel?.text = translateWord
            }
    }
//        if let imageUrl = fighterToSet.thumbnail {
//            if let image = ImageClient.getImage(stringURL: imageUrl){
//                cell.imageView?.image = image
//            }
//        }
        var urlString = ""
        
        if let imageUrl = fighterToSet.thumbnail{
        urlString = imageUrl
        if let image = ImageHelper.shared.image(forKey: imageUrl as NSString) {
            cell.imageView?.image = image
        } else {
            fighterActivityIndicator.startAnimating()
            ImageHelper.shared.fetchImage(urlString: fighterToSet.thumbnail!) { (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                } else if let image = image {
                    if urlString == imageUrl {
                    cell.imageView?.image = image
                }
                }
                self.fighterActivityIndicator.stopAnimating()
            }
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
            self.getFighters()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        DispatchQueue.main.async{
            if searchBar.text!.isEmpty{
                self.getFighters()
            }
        }
    }
}
