//
//  AppDelegate.swift
//  Assignment1_Nitin
//
//  Created by Xcode User on 2020-02-02.
//  Copyright © 2020 Xcode User. All rights reserved.
//



import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //
    var databaseName : String? = "NitinAssign2.db"
    var databasePath : String?
    var people : [Data] = []


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        
        databasePath = documentsDir.appending("/" + databaseName!)
        
        checkAndCreateDatabase()
        
        readDataFromDatabase()
        
        
        
        return true
    }
    
    
    func readDataFromDatabase(){
       
        people.removeAll()
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath!)")
            
            var queryStatement: OpaquePointer? = nil
            var queryStatementString : String = "select * from entries"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    
                    let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cname = sqlite3_column_text(queryStatement, 1)
                    let caddress = sqlite3_column_text(queryStatement, 2)
                    let cphone = sqlite3_column_text(queryStatement, 3)
                    let cemail = sqlite3_column_text(queryStatement, 4)
                    let cage = sqlite3_column_text(queryStatement, 5)
                    let cgender = sqlite3_column_text(queryStatement, 6)
                    let cbdate = sqlite3_column_text(queryStatement, 7)
                    let cavatar = sqlite3_column_text(queryStatement, 8)
                    
                    let name = String(cString: cname!)
                    let address = String(cString: caddress!)
                    let phone = String(cString: cphone!)
                    let email = String(cString: cemail!)
                    let bdate = String(cString: cbdate!)
                    let avatar = String(cString: cavatar!)
                    let gender =  String(cString: cgender!)
                    let age =  String(cString: cage!)
                    
                    let data : Data = Data.init()
                    data.initWithData(theRow: id, theName: name, theAddress: address, thePhone: phone, theEmail: email, theAge: age, theGender: gender, theBdate: bdate, theAvatar: avatar)
                    people.append(data)
                    
                    print("Query Result:")
                    print("\(id) | \(name) | \(address) | \(phone)| \(email)| \(age)| \(gender)| \(bdate)| \(avatar)")
                    
                }

                    sqlite3_finalize(queryStatement)
                
                }
                
            
                
            
            else{
                print("Select statement error")
            }
            
            sqlite3_close(db)
            
        }
        
        else{
            print("unable to open")
        }
        
    }
    
    
    
    func insertDatabase(person : Data) -> Bool{
        
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            
            var insertStatement : OpaquePointer? = nil
            var insertStatementString : String = "insert into entries values(NULL, ?, ?, ?, ?, ?, ?, ?, ?)"
            
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                
                let nameStr = person.name! as NSString
                let addressStr = person.address! as NSString
                let phoneStr = person.phone! as NSString
                let emailStr = person.email! as NSString
                let ageStr = person.age! as NSString
                let genderStr = person.gender! as NSString
                let bdateStr = person.bdate! as NSString
                let avatarStr = person.avatar! as NSString
                
                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, addressStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, phoneStr.utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 4, emailStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, ageStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, genderStr.utf8String, -1, nil)
                
                sqlite3_bind_text(insertStatement, 7, bdateStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 8, avatarStr.utf8String, -1, nil)
                
                if sqlite3_step(insertStatement) == SQLITE_DONE{
                    
                    let rowId = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row no: \(rowId)")
                }
                else{
                    print("Could not insert row")
                    returnCode = false
                }
                
                sqlite3_finalize(insertStatement)
                
            }
            
            else{
                print("insert not working")
                returnCode = false
            }
            
            sqlite3_close(db)
            
            
        }
        else{
            print("Unable to open database")
            returnCode = false
        }
        
        
        
        return returnCode
    }
    
    
    
    func checkAndCreateDatabase(){
        
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        
        if success{
            return
        }
        
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return
        
    }
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


