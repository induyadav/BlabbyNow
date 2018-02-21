//
//  RecordCollectionCollectionViewController.swift
//  blabby
//
//  Created by Ashutosh on 08/01/18.
//  Copyright © 2018 Ashutosh Mane. All rights reserved.
//

import UIKit





class RecordCollectionViewController: UICollectionViewController
{
    let reuseIdentifier = "Collection Cell"
    var names = ["asdfg","asdfg","asdfg","asdfg"]
    var images:[UIImage]=[#imageLiteral(resourceName: "profile 1"),#imageLiteral(resourceName: "profile 2"),#imageLiteral(resourceName: "profile 3"),#imageLiteral(resourceName: "profile 4"),#imageLiteral(resourceName: "profile 5")]
    var onEar:UIImage=#imageLiteral(resourceName: "onear.JPG")
    var users = [User]()
    var flag:Bool=false
    var temp:Int?
    
    var objRecordVC = RecordViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" collection view connected")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

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
        
                //func call for didSelect = play on select
            if initialState==true
        {
                print(" play on select")
                print(indexPath.row)
            
                print(flag)
            let cell = collectionView.cellForItem(at: indexPath)
            if let tcell=cell as! RecordCollectionViewCell!
            {
                if flag==false
                {
                    tcell.roundedImage.image=#imageLiteral(resourceName: "onEar")
                    print("set top onEar 2")
                    flag=true
                    temp=indexPath.row
                    
                    
                }
                else if temp==indexPath.row
                    {
                        print("blab paused")
                        tcell.roundedImage.image=images[indexPath.row]
                        flag=false
                        
                    }
                    else
                    {
                        tcell.roundedImage.image=#imageLiteral(resourceName: "onEar")
                        flag=false
                        temp=indexPath.row
                    }
            }
        }
                //func call for didHighlight = select for send
            if initialState==false
                {
                        print(" select for send")
                    let cell = collectionView.cellForItem(at: indexPath)
                    if let tcell=cell as! RecordCollectionViewCell!
                    
                        {
                          tcell.roundedImage.image=#imageLiteral(resourceName: "selectToSend")
                        }
                }
                    
                
    }
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        if initialState==true
        {
            let cell=collectionView.cellForItem(at: indexPath )
            
            print("this is  deselected\(indexPath.row)")
            if let tcell=cell as! RecordCollectionViewCell!
            {

                tcell.roundedImage.image=images[indexPath.row]
          
            }
        }
        else{
           return
        }
        
        
    }
    
    
}
