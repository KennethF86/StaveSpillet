//
//  ViewController.swift
//  StaveSpillet
//
//  Created by Kenneth Frandsen on 25/04/2017.
//  Copyright © 2017 Kenneth Frandsen. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var UiLabel: UILabel!

    @IBAction func StartKnap(_ sender: UIButton) {
        
        // bruges til at printe så der kan holdes styr på hvad der bliver trykket.
        // resten er sat i storyboard hvad der skal ske med de enkelte kanpper.
        print("StartKnap")
        
    }
    
    @IBAction func HighScor(_ sender: UIButton) {
        
        // bruges til at printe så der kan holdes styr på hvad der bliver trykket.
        // resten er sat i storyboard hvad der skal ske med de enkelte kanpper.
        
        print("HighScor")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

