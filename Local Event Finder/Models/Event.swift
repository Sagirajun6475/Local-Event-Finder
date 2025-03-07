//
//  Event.swift
//  Local Event Finder
//
//  Created by Nikhil Varma on 9/24/24.
//

import Foundation

struct Event: Identifiable {
    let id: UUID
    let name: String
    let date: Date
    //let time: TimeZone
    let location: String
    let description: String
    let imageUrl: String // URL for the event image
}
