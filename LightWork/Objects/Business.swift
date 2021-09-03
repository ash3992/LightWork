//
//  Business.swift
//  LightWork
//
//  Created by Test User on 9/2/21.
//

import Foundation
class Business {
   
    var businessName: String
    var address: String
    var email: String
    var firstName: String
    var lastName: String
    var catgory: String
    var pricing: String
    var description: String
    var profilePicture: String
    var businessPicture: String
    var monDay: [String]
    var tuesDay: [String]
    var wednesDay: [String]
    var thursDay: [String]
    var friDay: [String]
    var saturDay: [String]
    var sunDay: [String]
    
    
    init(businessName: String, address: String, email: String, firstName: String, lastName: String, catgory: String, pricing: String, description: String, profilePicture: String, businessPicture: String, monDay: [String], tuesDay: [String], wednesDay: [String], thursDay: [String], friDay: [String], saturDay : [String], sunDay  : [String]) {
     
        self.businessName = businessName
        self.address = address
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.catgory = catgory
        self.pricing = pricing
        self.description = description
        self.profilePicture = profilePicture
        self.businessPicture = businessPicture
        self.monDay = monDay
        self.tuesDay = tuesDay
        self.wednesDay = wednesDay
        self.thursDay = thursDay
        self.friDay = friDay
        self.saturDay = saturDay
        self.sunDay = sunDay
        
    }
 


}
