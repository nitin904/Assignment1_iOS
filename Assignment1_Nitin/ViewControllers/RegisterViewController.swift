//
//  RegisterViewController.swift
//  Assignment1_Nitin
//
//  Created by Xcode User on 2020-02-03.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController , UITextFieldDelegate{
    
    //let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet var tfName : UITextField!
     @IBOutlet var tfAddress : UITextField!
    @IBOutlet var tfPhone : UITextField!
    @IBOutlet var tfEmail : UITextField!
    
    @IBOutlet var sgGender : UISegmentedControl!
    @IBOutlet var sgAvatar : UISegmentedControl!
    
    @IBOutlet var datePicker : UIDatePicker!
    
    @IBOutlet var lbAge : UILabel!
    
    var genderVal : String = ""
    var avatarVal : String = ""
    var bDateVal : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateGender()

        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @IBAction func slider(sender : UISlider){
        lbAge.text = String(Int(sender.value))
    }
    
    @IBAction func registerUser(sender : UIButton)
    {
        var name = tfName?.text
        var email = tfEmail?.text
        
        let alertBox = UIAlertController(title: "Registration", message: "Thank you  '" + String(name!) + "' of email '" + String(email!) + "' for registration!" , preferredStyle: .alert)
        
       let cancelAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        alertBox.addAction(cancelAction)
        
        present(alertBox, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    func updateGender(){
        
        let gender = sgGender.selectedSegmentIndex
        
        if gender == 0{
            genderVal = "Male"
        }
        
        else if gender == 1{
            genderVal = "Female"
        }
        else{
            genderVal = "Other"
        }
        
    }
    
    @IBAction func genderSegmentDidChange(sender : UISegmentedControl)
    {
        updateGender()
    }
    
    
    func updateAvatar(){
    
    let avatar = sgAvatar.selectedSegmentIndex
    
    if avatar == 0{
    avatarVal = "avatar1.png"
    }
    
    else if avatar == 1{
    avatarVal = "avatar2.png"
    }
    else{
        avatarVal = "avatar3.jpg"
    }
    
    }
    
    @IBAction func avatarSegmentDidChange(sender : UISegmentedControl)
    {
        updateAvatar()
    }
    
    
    func updateDate(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        bDateVal = formatter.string(from: datePicker.date)
    }
    
    @IBAction func dateSelectedPicker(sender : Any){
        
        updateDate()
        
    }
    
    
    
    @IBAction func addPerson(sender : Any){
        
        let person : Data = Data.init()
        person.initWithData(theRow: 0, theName: tfName.text!, theAddress: tfAddress.text!, thePhone: tfPhone.text!, theEmail: tfEmail.text!, theAge: lbAge.text!, theGender: genderVal, theBdate: bDateVal, theAvatar: avatarVal)
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let retunCode = mainDelegate.insertDatabase(person: person)
        
        var returnMsg : String = "Person Added"
        
        if retunCode == false{
            returnMsg = "Person add failed"
        }
        
        let alertController = UIAlertController(title: "Sqlite add", message: returnMsg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
            alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
        
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
