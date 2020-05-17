//
//  TableViewController.swift
//  Assignment1_Nitin
//
//  Created by Xcode User on 2020-03-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var tableView = UITableView?.self
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.people.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.people[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.people[rowNum].email
        
        tableCell.myImageView.image = UIImage(named: (mainDelegate.people[rowNum].avatar ?? nil)!)
        
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNum = indexPath.row
        
        var msgStr = "\(mainDelegate.people[rowNum].address!)\n\(mainDelegate.people[rowNum].phone!)\n\(mainDelegate.people[rowNum].email!)\n\(mainDelegate.people[rowNum].age!)\n\(mainDelegate.people[rowNum].gender!)\n\(mainDelegate.people[rowNum].bdate!)"
        
        let alertController = UIAlertController(title: mainDelegate.people[rowNum].name, message: msgStr, preferredStyle: .alert)
                                    
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainDelegate.readDataFromDatabase()
        
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
