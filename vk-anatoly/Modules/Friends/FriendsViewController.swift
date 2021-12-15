//
//  FriendsViewController.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 04.12.2021.
//

import UIKit

final class FriendsViewController: UITableViewController {
    
    private var friends: [FriendDTO] = []
    
    private let friendsAPI = FriendsAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        friendsAPI.getFriends { friends in
            self.friends = friends
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let friend: FriendDTO = friends[indexPath.row]
        
        cell.textLabel?.text = "\(friend.firstName) \(friend.lastName)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //IndexPath section/row - 0/10
        
        let friend = friends[indexPath.row]
        
        
        //let detailVC = DetailViewController(employer: employer)
        
        //UINavigationController переход
        //self.navigationController?.pushViewController(detailVC, animated: true)
        
        //Передач через свойство - 1 способ
        //detailVC.employer = employer
    }
    
    
}
