//
//  GameViewController.swift
//  StaveSpillet
//
//  Created by Kenneth Frandsen on 25/04/2017.
//  Copyright © 2017 Kenneth Frandsen. All rights reserved.
//

import UIKit
import FirebaseDatabase


class GameViewController: UIViewController{
    
    var genstand = ""
    var nameOfImages = ""
    var antalForsøg = 0
    var number = 0
    var ref: FIRDatabaseReference?
    let date = Date()
    let formatter = DateFormatter()
    
    
    @IBAction func returnbuttonpushedActionTrigger(_ sender: Any) {
        
        print("Return brugt")
        tjekOgValidering()
       
    }
    
    @IBOutlet var Photo: UIImageView!
    
    @IBOutlet var NameOfImagesTextField: UITextField!
    
    @IBAction func SvarButton(_ sender: UIButton) {
      tjekOgValidering()
        
    }
    
    
    @IBAction func BackToMainFromGame(_ sender: UIButton) {
        print("Back to main from game")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       ref = FIRDatabase.database().reference()
        
        //Activer Keboard efter viewet er loadet
        self.NameOfImagesTextField.becomeFirstResponder()
        NameOfImagesTextField.autocapitalizationType = .allCharacters
        NameOfImagesTextField.autocorrectionType = .no
    
        
        
        randomPhoto()
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomPhoto() {
        
        //Et tilfældigt tal mellem 0-99
        number = Int(arc4random_uniform(100))
        
        switch (number)
        {
        case 0...16:
            print("Hest")
            //tjekker for om det var hest gangen før hvis det var trækker den igen.
            if(genstand == "HEST"){
                print("Blev hest igen")
                randomPhoto()
            }
                else{
                //Hvis det ikke var hest skal man gætte den.
            self.Photo.image = UIImage(named: "Hest")
            genstand = "HEST"
            }
            
        case 17...33:
            print("Bi")
            if(genstand == "BI"){
                randomPhoto()
            }
            else{
            
            self.Photo.image = UIImage(named: "Bi" )
            genstand = "BI"
            }
            
        case 34...50:
            print("Bil")
            if(genstand == "BIL"){
                randomPhoto()
            }
            else{
            self.Photo.image = UIImage(named: "Bil" )
            genstand = "BIL"
            }
        case 51...66:
            print("Ged")
            if(genstand == "GED"){
                randomPhoto()
            }
            else{
                self.Photo.image = UIImage(named: "ged" )
                genstand = "GED"
            }
        case 67...82:
            print("hus")
            if(genstand == "HUS"){
                randomPhoto()
            }
            else{
                self.Photo.image = UIImage(named: "hus" )
                genstand = "HUS"
            }
        case 83...99:
            print("bro")
            if(genstand == "BRO"){
                randomPhoto()
            }
            else{
                self.Photo.image = UIImage(named: "bro" )
                genstand = "BRO"
            }
        default:
            break
        }
    }
    
    func rightAnswer(){
        
        //setter kant størrelsen til 4
        self.Photo.layer.borderWidth = 4
        // sætter kant farven til Grøn
        self.Photo.layer.borderColor = UIColor.green.cgColor
        
        //Henter og sætter billedet til Godkendt
        let rigtigImage = UIImage(named:"Godkendt")
        let overlayOfRigtigImageView = UIImageView(image:rigtigImage)
        
        //Tilføjer billeder godkendt som et lag oven på ImagesViewet
        self.Photo.addSubview(overlayOfRigtigImageView)
        
        //sætter en tid til 2 sec før anden kode kan køres.
        let when = DispatchTime.now() + 1 // 1 er den tid den bliver forsinket med
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            //fjerner overlaget igen
            overlayOfRigtigImageView.removeFromSuperview()
            
            // vælger et random billede fra de mulige samt rydder textfelt for text
            self.randomPhoto()
            self.NameOfImagesTextField.text = ""
            
            //Sætter kanten til 0 i størrelse
            self.Photo.layer.borderWidth = 0
        }
    
    }
    
    func wrongeAnswer(){
        
        // sætter størrelsen til 4
        self.Photo.layer.borderWidth = 4
        
        //sætter kant farven til rød
        self.Photo.layer.borderColor = UIColor.red.cgColor
        
        //Loader billedet ind
        let forkertImage = UIImage(named:"Forkert")
        
        //laver images til et imagesView
        let overlayOfForkertImageView = UIImageView(image:forkertImage)
        
        //Tilføjer Images view som et subview
        self.Photo.addSubview(overlayOfForkertImageView)
        
        //sætter tid til 1 sec før den køre videre.
        let when = DispatchTime.now() + 1 // 1 er den tid den bliver forsinket med
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            //Fjerne subimagesView
            overlayOfForkertImageView.removeFromSuperview()
            
            //Sletter texten i textfeild
            self.NameOfImagesTextField.text = ""
        }
    
    
    
    }
    
    func validering(){
        
        
        
        let textOfTextimages: String = NameOfImagesTextField.text!

        
        if(textOfTextimages == genstand){
            
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            
            let tid = formatter.string(from: date)
            
            
            //tæller antal forsøg der er brugt
            antalForsøg = antalForsøg + 1
            //Laver en string der kan printes.
            let antalForsøgString = " " + "Antal forsøg " + "\(antalForsøg)"
            
            //sender data i denne tring til Firebase bliver gemt under UserID
            ref?.child(UserDefaults.standard.object(forKey: "UserID") as! String).childByAutoId().setValue(NameOfImagesTextField.text! + antalForsøgString + ", dato:" + tid)
            print("Rigtigt")
    
            rightAnswer()
            antalForsøg = 0
            
            
            
            
        }else {
            print("Forkert")
            //tæller forsøg der er brugt op samt køre funtionen wrongeanswer.
            antalForsøg = antalForsøg + 1
            wrongeAnswer()
        }
    }
    
    func tjekOgValidering(){
        //Bruger guard til at tjekke om textfield er tomt eller ikke
        guard let text = NameOfImagesTextField.text, !text.isEmpty else {
            print("Mangler intastning")
            return
        }
        validering()
    }

    
    
    
    
}



