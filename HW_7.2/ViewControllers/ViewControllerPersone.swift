//
//  ViewControllerPersone.swift
//  HW_7.2
//
//  Created by Elizaveta Rogozhina on 07.06.2021.
//

import UIKit

class ViewControllerPersone: UIViewController{
    
    @IBOutlet weak var personeImage: UIImageView!
    @IBOutlet weak var personeName: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var liveStatusLabel: UILabel!
    @IBOutlet weak var species_genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var firstSeenLabel: UILabel!
    @IBOutlet weak var episodeInfoTable: UITableView!
    
    var episodes_name: [String] = [],
        episodes_s_e: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModelPersone = ViewModelPersone()
        viewModelPersone.personeDelegate = self
        self.episodeInfoTable.reloadData()
        self.episodeInfoTable.rowHeight = 50
        self.episodeInfoTable.dataSource = self
    }
}

extension ViewControllerPersone: uploadPersone {
    func uploadPersoneInfo(name_: String, status_: String, gender_: String, last_loc_: String, species_: String, icon_: UIImage, id_: Int, episodes_names: [String], episodes_s_e: [String]) {
        personeName.text = name_
        liveStatusLabel.text = status_
        statusView.backgroundColor = ChangeColorStatus().colorStatus(status: status_)
        locationLabel.text = last_loc_
        species_genderLabel.text = "\(species_) (\(gender_))"
        personeImage.image = icon_
        self.episodes_s_e = episodes_s_e
        self.episodes_name = episodes_names
        firstSeenLabel.text = episodes_names[0]
        self.episodeInfoTable.reloadData()
    }
}


extension ViewControllerPersone: UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes_name.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episode", for: indexPath) as! TableViewCellPersoneEpisodesInfo
        cell.episodeLabel_1.text = episodes_name[indexPath.row]
        cell.episode_s_e.text = episodes_s_e[indexPath.row]
        return cell
    }
}
