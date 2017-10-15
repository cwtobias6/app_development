//
//  SelfDrivingCar.swift
//  Classes and Objects
//
//  Created by Christian Tobias on 10/15/17.
//  Copyright © 2017 Christian Tobias. All rights reserved.
//

import Foundation


class SelfDrivingCar: Car {
    
    var destination: String?
    
    override func drive() {
        super.drive()
        
        if let userSetDestination = destination {
        
        print("Driving towards " + userSetDestination)
            
        }
    }
}
