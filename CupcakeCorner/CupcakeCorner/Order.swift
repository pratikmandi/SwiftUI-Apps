//
//  Order.swift
//  CupcakeCorner
//
//  Created by Pratik Mandi on 17/12/25.
//

import Foundation

@Observable
class Order{
    let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 1

    var specialRequestEnabled = false {
        didSet{
            // When we disable specialRequest, extraFrosting and addSprinkles should also change it's state back to false. if not done, it retains state to true(if enabled earlier) even if we disable specialRequestEnabled
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var postCode = ""
    
    var isValidAddress: Bool {
        return !name.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !postCode.isEmpty
    }
}
