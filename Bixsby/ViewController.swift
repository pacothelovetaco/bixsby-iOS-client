//
//  ViewController.swift
//  Bixsby
//
//  Created by Justin on 3/3/15.
//  Copyright (c) 2015 Justin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/

    let bixsbyServer = ServerCommunicator()
    
    @IBOutlet weak var bixsbyResponseDisplay: UILabel!
    
    @IBOutlet weak var userInputField: UITextField!
    
    @IBAction func sendInput() {
        var response = bixsbyServer.respondTo("hello")
        bixsbyResponseDisplay.text = "\(bixsbyResponseDisplay)\n" + response
    }
    

}

