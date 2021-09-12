//
//  JobDescrption.swift
//  LightWork
//
//  Created by Test User on 9/8/21.
//

import Foundation
class JobDescrption {
    
    var phoneNumber : String
    var address: String
    var jobDescrption: String
    var lon: String
    var lat: String
    
    init(phoneNumber: String, address: String, jobDescrption: String, lon: String, lat: String){
        self.phoneNumber = phoneNumber
        self.address = address
        self.jobDescrption = jobDescrption
        self.lon = lon
        self.lat = lat
    }
}
