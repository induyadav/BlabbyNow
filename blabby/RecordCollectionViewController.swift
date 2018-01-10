//
//  RecordCollectionCollectionViewController.swift
//  blabby
//
//  Created by Ashutosh on 08/01/18.
//  Copyright © 2018 Ashutosh Mane. All rights reserved.
//

import UIKit

let reuseIdentifier = "Collection Cell"
var names = ["asdfg","asdfg","asdfg","asdfg"]
var images:[UIImage]=[#imageLiteral(resourceName: "profile 1"),#imageLiteral(resourceName: "profile 2"),#imageLiteral(resourceName: "profile 3"),#imageLiteral(resourceName: "profile 4"),#imageLiteral(resourceName: "profile 5")]
var users = [User]()


class RecordCollectionViewController: UICollectionViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" collection view connected")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        print("names.count=\(names.count)")
        return names.count
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       //for collection view to find resusable cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as UICollectionViewCell
        
        if let textCell = cell as? RecordCollectionViewCell{
//            let user = users[indexPath.row]
        print ("collection view func access")
        
        textCell.myLabel?.text = names[indexPath.row]
//      textCell.myLabel?.text = user.name
        textCell.roundedImage.image = images[indexPath.row]
            
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("clicked")
        
    }
   
    
}
