//
//  ViewController.swift
//  Assignment1_Nitin
//
//  Created by Xcode User on 2020-02-02.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var lblTable : UILabel!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToHomeViewController(sender : UIStoryboardSegue)
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch = touches.first!
        let touchPoint : CGPoint = touch.location(in: self.view!)
        
        let tableFrame : CGRect = lblTable.frame
        
        if tableFrame.contains(touchPoint){
            performSegue(withIdentifier: "HomeSegueToTable", sender: self)
        }
        
    }
    
    

}

