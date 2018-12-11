//
//  ViewController.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 12/10/18.
//  Copyright © 2018 Leandro Wauters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var buttonTaps = 1
    @IBOutlet var filterByButtons: [UIButton]!
    
    @IBOutlet weak var fighterSearchBar: UISearchBar!
    
    @IBOutlet weak var fighterTableView: UITableView!
    
    var fighters = [UFCFighter]() {
        didSet{
            DispatchQueue.main.async {
                self.fighterTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
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
            fighters = fighters.sorted{$0.last_name < $1.last_name}
        } else {
            fighters = fighters.reversed()
        }
            
        default:
            print("error")
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
        cell.detailTextLabel?.text = fighterToSet.weight_class
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
