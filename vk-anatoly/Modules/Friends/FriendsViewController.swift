//
//  FriendsViewController.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 04.12.2021.
//

import UIKit

class FriendsViewController: UITableViewController {

    let friends = ["Jack", "Brad", "Lucky"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = friends[indexPath.row]

        return cell
    }
    

}
