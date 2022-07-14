//
//  Response.swift
//  iOS_sirius_test
//
//  Created by The GORDEEVS on 14.07.2022.
//

import Foundation

struct Response: Codable {
    let body: Body
}

struct Body: Codable {
    let services: [Service]
}
