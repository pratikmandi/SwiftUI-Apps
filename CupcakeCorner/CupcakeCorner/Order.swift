//
//  Order.swift
//  CupcakeCorner
//
//  Created by Pratik Mandi on 17/12/25.
//

import Foundation

@Observable
class Order: Codable {
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
    
    var price: Decimal {
        // ₹30 per cake
        var cost = Decimal(quantity) * 30

        // ₹5/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity) * 5
        }

        // ₹2/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) * 2
        }

        return cost
    }
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _postCode = "postCode"
    }
}
