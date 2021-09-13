//
//  Appointment.swift
//  LightWork
//
//  Created by Test User on 9/10/21.
//

import Foundation
class Appointment {
    
   
    var address: String
    var phoneNumber : String
    var businessName : String
    var date : String
    var dayAndMonth : String
    var description : String
    var firstName : String
    var lastName : String
    var status: String
    var time: String
    var userEmail: String
    var busiEmail : String
    var id : String
    var lat : String
    var lon : String
    
    
    init(address: String, phoneNumber: String, businessName: String, date: String, dayAndMonth: String, description: String, firstName: String, lastName: String, status: String, time: String, userEmail: String, busiEmail : String, id: String, lat: String, lon: String){
        
        self.address = address
        self.phoneNumber = phoneNumber
        self.businessName = businessName
        self.date = date
        self.dayAndMonth = dayAndMonth
        self.description = description
        self.firstName = firstName
        self.lastName = lastName
        self.status = status
        self.time = time
        self.userEmail = userEmail
        self.busiEmail = busiEmail
        self.id = id
        self.lat = lat
        self.lon = lon
        
    }
    
}
