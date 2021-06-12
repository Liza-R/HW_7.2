//
//  ViewController.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 06.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

var personeID = 0

class ViewController: UIViewController{
    
    var names: [String] = [],
        searchResult: [String] = [],
        status: [String] = [],
        last_loc: [String] = [],
        species: [String] = [],
        icon: [UIImage] = [],
        disposeBag = DisposeBag(),
        newNames: [String] = [],
        newStatus: [String] = [],
        newLast_loc: [String] = [],
        newSpecies: [String] = [],
        newIcons: [UIImage] = []

    
    @IBOutlet weak var searchPersoneBar: UISearchBar!
    @IBOutlet weak var allTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = ViewModelTable()
        viewModel.infoDelegate = self
        self.allTable.delegate = self
        self.allTable.dataSource = self
        self.searchPersoneBar.delegate = self
        
        self.allTable.rx.itemSelected
          .subscribe(onNext: { indexPath in
            personeID = indexPath.row + 1
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "PersoneCard") as! ViewControllerPersone
            self.present(newViewController, animated: true, completion: nil)
          }).disposed(by: disposeBag)
    }
}

extension ViewController: uploadInfo {
    func uploadAllInfo(names: [String], status: [String], last_loc: [String], species: [String], icons: [UIImage]){
        self.names = names
        searchResult = names
        self.status = status
        self.last_loc = last_loc
        self.species = species
        self.icon = icons
        allTable.reloadData()
        self.newNames = self.names
        self.newStatus = self.status
        self.newLast_loc = self.last_loc
        self.newSpecies = self.species
        self.newIcons = self.icon
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            names = searchText.isEmpty ? searchResult: searchResult.filter{ (item: String) -> Bool in
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
        for (i, j) in newNames.enumerated(){
            for (k, m) in names.enumerated(){
                if j == m{
                    self.status[k] = newStatus[i]
                    self.last_loc[k] = newLast_loc[i]
                    self.species[k] = newSpecies[i]
                    self.icon[k] = newIcons[i]
                }
            }
        }
        allTable.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "base_info", for: indexPath) as! AllPersoneTableViewCell
        
            cell.namePersonLabel.text = names[indexPath.row]
            cell.last_locationLabel.text = last_loc[indexPath.row]
            cell.statusPersonLabel.text = "\(status[indexPath.row]) - \(species[indexPath.row])"
            cell.statusView.backgroundColor = ChangeColorStatus().colorStatus(status: status[indexPath.row])
            cell.personImage.image = icon[indexPath.row]
        
        return cell
    }
}

extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)"
    }
}
