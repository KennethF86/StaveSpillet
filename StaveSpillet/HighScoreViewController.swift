//
//  HighScoreViewController.swift
//  StaveSpillet
//
//  Created by Kenneth Frandsen on 25/04/2017.
//  Copyright © 2017 Kenneth Frandsen. All rights reserved.
//

import UIKit
import FirebaseDatabase


class HighScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var ref: FIRDatabaseReference?
    var dataBaseHandler: FIRDatabaseHandle?
    var postData = [String]()

    @IBOutlet var textfield: UITextField!
    
    @IBAction func logUduiButton(_ sender: UIButton) {
        
        // når der skal logges ud bruges denne. henter
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
    }
    
    @IBAction func BackToMainFromHScore(_ sender: UIButton) {
        
        print("Back to Main from HScore")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UserDefaults.standard.bool(forKey: "isLoggedIn") == true){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = FIRDatabase.database().reference()
        dataBaseHandler = ref?.child(UserDefaults.standard.object(forKey: "UserID") as! String).observe(.childAdded, with: { (snapshot)  in
            
            //kode der køres hvergang et barn bliver tilføjet under "Posts"
            // Tager daten fra snapshot og ligger det i arrayet postData
            
            let post = snapshot.value
            
            if let actualpost = post{
                
                self.postData.append(actualpost as! String)
                
                self.tableView.reloadData()
                
            }
            else{
                print("Mangler id")
                
                let newViewController = LoginViewController()
                self.navigationController?.pushViewController(newViewController, animated: true)
                
            }
            
            
        })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        
        return cell!
    }
 

}
