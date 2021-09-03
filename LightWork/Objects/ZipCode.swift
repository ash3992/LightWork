//
//  ZipCode.swift
//  LightWork
//
//  Created by Test User on 8/27/21.
//

import Foundation
class ZipCode {
    var city: String
    var population : Int
    var state: String
    var idZip: String
    var loc: [Double]
    
    init(city: String, population: Int, state: String, idZip: String, loc: [Double]){
           
           
        self.city = city
        self.population = population
        self.state = state
        self.idZip = idZip
        self.loc = loc
        
       }

}
