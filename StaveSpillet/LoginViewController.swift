//
//  LoginViewController.swift
//  StaveSpillet
//
//  Created by Kenneth Frandsen on 04/05/2017.
//  Copyright © 2017 Kenneth Frandsen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var brugernavnTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func brugerIdActionTriggeder(_ sender: Any) {
    
        print("Return brugt   Bruger id")
        // bruges til at flytter cursor til password linjen.
        passwordTextField.becomeFirstResponder()
        
    }
    @IBAction func passwordActiontriggerd(_ sender: Any) {
    
        print("Return brugt     password")
        //Køre function der tjekker om der er logget in.
        tjekOmtetxfeidlErTomt()
    }
    
    @IBAction func loginUiButton(_ sender: UIButton) {
        tjekOmtetxfeidlErTomt()
    }
    
    @IBAction func fortrydLoginUibutton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tjekOmtetxfeidlErTomt(){
        //if tjekker om et eller begge textfields er tomme.
        if((brugernavnTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!){
           print("tom")
            
            indtastningMangler()
            
        }else {
            print("ikke tom")
            
            // Bruges til at gemme UserID, password og en bool om der er logget in eller ej
            UserDefaults.standard.set(brugernavnTextField.text, forKey: "UserID")
            UserDefaults.standard.set(passwordTextField.text, forKey: "UserIdentifyer")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            performSegue(withIdentifier: "Login", sender: self)
   
        }
        
        
 }
    func indtastningMangler(){
        
        //popup alarm der viser at der ikke er intastet noget i både password og brugernavn.
        let alert = UIAlertController(title: "Alert", message: "Mangler intastning af Brugernavn og Kodeord", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
