//
//  Car.swift
//  Classes and Objects
//
//  Created by Christian Tobias on 10/14/17.
//  Copyright © 2017 Christian Tobias. All rights reserved.
//

import Foundation

enum carType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    
    var color = "black"
    var numberofSeats = 5
    var typeOfCar: carType = .Coupe
    
    init() {
        
    }
    
    convenience init(customerChosenColor: String) {
        self.init()
        color = customerChosenColor
    }
}
