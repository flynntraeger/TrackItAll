//
//  NewEntryVM.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 26/05/2021.
//
// The idea of an input

import Foundation

enum InputType: Int, Codable, CaseIterable {
    case textField
    case intIncrement
    case slider
    case photo
}

struct Input: Codable, Hashable {
    var name: String
    var InputType: InputType
}


