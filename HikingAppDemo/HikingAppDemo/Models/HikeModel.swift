//
//  HikeModel.swift
//  HikingAppDemo
//
//  Created by Pratik Mandi on 05/12/25.
//

import Foundation
import SwiftUI

struct HikeModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let distance: Int
    let image: String
}
