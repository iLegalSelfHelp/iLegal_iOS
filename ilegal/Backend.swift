//
//  Backend.swift
//  ilegal
//
//  Created by Matthew Rigdon on 2/7/17.
//  Copyright © 2017 Jordan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Backend: NSObject {
    
    // MARK: - Properties
    
    private static var rootURL = "http://159.203.67.188:8080/Dev"
    
    // MARK: - Functions
    
    static func login(username: String, password: String, completion: @escaping (_ error: String?) -> Void) {
        Alamofire.request("\(rootURL)/SignIn?Username=\(username)&Password=\(password)").responseJSON { response in
            switch response.result {
            case .success(let value):
                let outcome = JSON(value)
                if(outcome["Success"].intValue == 1){
                    //Log-In and go to CategoriesViewController
                    User.currentUser.firstName = outcome["FirstName"].stringValue
                    if(!outcome["MiddleInitial"].stringValue.isEmpty){
                        User.currentUser.middleInitial = outcome["MiddleInitial"].stringValue
                    } else{
                        User.currentUser.middleInitial = ""
                    }
                    User.currentUser.lastName = outcome["LastName"].stringValue
                    User.currentUser.email = outcome["EmailAddress"].stringValue
                    User.currentUser.password = outcome["Password"].stringValue
                    User.currentUser.addressOne = outcome["Address1"].stringValue
                    if(!outcome["Address2"].stringValue.isEmpty){
                        User.currentUser.addressTwo = outcome["Address2"].stringValue
                    } else {
                        User.currentUser.addressTwo = ""
                    }
                    User.currentUser.city = outcome["City"].stringValue
                    User.currentUser.state = outcome["State"].stringValue
                    User.currentUser.zipcode = outcome["PostalCode"].stringValue
                    User.currentUser.phone = outcome["PhoneNumber"].stringValue
                    User.currentUser.license = outcome["LicenseNumber"].stringValue
                    User.currentUser.DOB = outcome["DOB"].stringValue
                    User.currentUser.id = outcome["UserId"].stringValue
                    
                    //pull User's Saved Files
                    Backend.getSavedFiles()

                    completion(nil)
                } else{
                    // Password/Username is incorrect
                    completion("The Username and/or Password does not match our records, or you are not registered. Please try again.")
                }
            case .failure:
                // Password/Username is incorrect
                completion("The Username and/or Password does not match our records, or you are not registered. Please try again.")
            }
            
        }
    }
    
    static func saveUserLocal() {
        UserDefaults.standard.set(User.currentUser.dictionaryValue, forKey: "user")
        UserDefaults.standard.synchronize()
    }
    
    static func getSavedFiles(completion: ((_ error: String?) -> Void)? = nil) {
        Alamofire.request("\(rootURL)/ListPDF?Type=4&UserUniqueID=\(User.currentUser.id)").responseJSON { response in
            switch response.result {
            case .success(let value):
                var outcome = JSON(value)
                if(outcome["Success"].boolValue == true){
                    let temp = outcome["UserDocs"].count
                    if(temp > 0){
                        for i in 0...temp-1 {
                            let tempForm:Form = Form()
                            tempForm.id = outcome["UserDocs"][i][0].string
                            tempForm.location = outcome["UserDocs"][i][1].string
                            tempForm.title = outcome["UserDocs"][i][2].string
                            tempForm.subtitle = outcome["UserDocs"][i][3].string
                            User.currentUser.myFiles.append(tempForm)
                        }
                        completion?(nil)
                    }
                }
            case .failure:
                completion?("Something went wrong. Please try again later.")
            }
        }
    }
    
    static func getCategories(completion: @escaping (_ categories: [String]?) -> Void) {
        Alamofire.request("http://159.203.67.188:8080/Dev/ListPDF?Type=1").responseJSON { response in
            switch response.result {
            case .success(let value):
                let outcome = JSON(value)
                completion(outcome["Categories"].arrayObject as? [String])
            case .failure:
                completion(nil)
            }
        }
    }
    
}