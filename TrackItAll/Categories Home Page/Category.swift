//
//  Category.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 25/05/2021.
//
// The idea of a Category governs the whole app.
// It holds its own entry's which are made up of timestamped inputs
// The original idea for this app was to have the trackables be 100% customizable
// in terms of how many of each type you wanted and their range of counting etc.
// However, I spent far too long on this and ran out of time so had to get rid of the feature.

import Foundation
import SwiftUI

struct Category: Identifiable, Codable, Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id ==  rhs.id
    }
    
    var name: String
    var trackables: [Input]
    var entries: [Entry]
    var id: Int
    
    init(name: String, trackables: [Input], entries: [Entry], id: Int) {
        self.name = name
        self.trackables = trackables
        self.entries = entries
        self.id = id
    }
}

struct Entry: Codable, Hashable {
    let time: Date //label is time entry was subittmed
    var entryData: [EntryInput]
}

struct EntryInput: Codable, Hashable {
    let name: String
    let sliderInput: Float?
    let incrementInput: Int?
    let commentInput: String?
}



