//
//  Data.swift
//  Assignment1_Nitin
//
//  Created by Xcode User on 2020-03-29.
//  Copyright © 2020 Xcode User. All rights reserved.
//

import UIKit

class Data: NSObject {
    
    var id : Int?
    var name : String?
    var address : String?
    var phone : String?
    var email : String?
    var age : String?
    var gender : String?
    var bdate : String?
    var avatar : String?
    
    func initWithData(theRow i : Int, theName n : String,theAddress a : String, thePhone p : String, theEmail e : String, theAge ag : String, theGender g:String, theBdate b : String, theAvatar av: String ){
        
        id = i
        name = n
        address = a
        phone = p
        email = e
        age = ag
        gender = g
        bdate = b
        avatar = av
        
    }
    

}
