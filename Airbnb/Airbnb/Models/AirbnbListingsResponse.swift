//
//  AirbnbListingsResponse.swift
//  Airbnb
//
//  Created by dnlab on 2023/10/18.
//

import Foundation

struct AirbnbListingsResponse: Codable {
    let total_count: Int
    let results: [AirbnbListing]
}
