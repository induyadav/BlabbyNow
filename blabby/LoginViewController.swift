//
//  LoginViewController.swift
//  blabby
//
//  Created by Indu Yadav on 20/10/17.
//  Copyright © 2017 Ashutosh Mane. All rights reserved.
//
import  UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

//test commit ashutosh mane//

class LoginViewController: UIViewController{
   //object of data model cladd my info
    override func viewDidLoad() {
        super.viewDidLoad()
        

 
    }
    
    func registerUser() {
      
        guard let name = Username.text,let number = Mobileno.text
            else { print("form not valid")
                return}
        let values = ["name" : name, "number" : number]
        let ref = Database.database().reference(fromURL: "https://blabby-126d8.firebaseio.com/" )
        let usersReference = ref.child("Users").child(name)
        usersReference.updateChildValues(values) { (err, ref) in
            if (err != nil) {
                print(String(describing: LocalizedError.self))
                return
            }
            print("user registered successfully into firbase db")
        }
    }
    
    @IBOutlet weak var UsernameLabel: UILabel!
    @IBOutlet weak var MobilenoLabel: UILabel!
    @IBOutlet weak var CodeLabel: UILabel!
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Mobileno: UITextField!
    @IBOutlet weak var code: UITextField!
    
    
    @IBAction func Sendcode(_ sender: Any)
    {
        let alert = UIAlertController(title: "Phone Number", message: "is this your phone number? \n \(Mobileno.text!)", preferredStyle: .alert)
       
            let action = UIAlertAction(title: "yes",style: .default){(UIAlertAction) in PhoneAuthProvider.provider().verifyPhoneNumber(self.Mobileno.text!)
                { (verificationID, error) in
                if error != nil
                {
                    print((String(describing:error?.localizedDescription)))
                }
                 // Sign in using the verificationID and the code sent to the user
                 // ...
                else
                {
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "authVID")
                    print("verification id is \(String(describing: verificationID))!")

                }
                }
            }
        let cancel = UIAlertAction(title: "No", style: .cancel , handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert , animated: true, completion: nil)
    
    }
    
    
    @IBAction func signup(_ sender: Any) {
        
     let defaults = UserDefaults.standard
        let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID : defaults.string(forKey: "authVID")!, verificationCode: code.text! )
        Auth.auth().signIn(with: credential){(user,error) in
            if error != nil{
                print((String(describing:error?.localizedDescription)))
            } else{
                print("Phone no: \(String(describing: user?.phoneNumber))")
              
                
                    self.performSegue(withIdentifier: "code", sender: self)
                    self.registerUser()
                
                
                
                
                    
                }
            }
        }
    


}
   
    

    

    
    

