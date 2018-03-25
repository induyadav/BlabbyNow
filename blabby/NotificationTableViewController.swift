//
//  NotificationTableViewController.swift
//  blabby
//
//  Created by Indu Yadav on 19/03/18.
//  Copyright © 2018 Ashutosh Mane. All rights reserved.
//

import UIKit

class NotificationTableViewController: UITableViewController

{

    var objNotificationVC = NotificationViewController()
    
    let reuseIdentitfierr = "Table Cell"
    var notificationCellLabelTextArray = ["Marei added you","Dave added you","wish Aparna on her birthday","Rai favorited your blab!","Sharddha added you"]
   var notificationCellActionButtonTextArray = ["Add her","Add him","Wish me","Thank her","Add her"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationCellLabelTextArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentitfierr, for: indexPath as IndexPath) as UITableViewCell
        
        if let notificationCell = cell as? NotificationTableViewCell{
            notificationCell.notificationTableViewCellLabel.text = notificationCellLabelTextArray[indexPath.row]
            notificationCell.notificationTableViewCellButton.setTitle("\(notificationCellActionButtonTextArray[indexPath.row])", for: .normal)
        }

        return cell
    }


}
