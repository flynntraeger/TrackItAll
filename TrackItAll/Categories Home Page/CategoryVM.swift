//
//  CategoryVM.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 26/05/2021.
//
// Handles the creation of some initial categories for demonstration purposes
// and the storing of the created categories and subsequent entries

import Foundation
import SwiftUI

class CategoryVM: ObservableObject {
    let name: String
    
    @Published var categories = [Category]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "Categories:" + name
    }

    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(categories), forKey: userDefaultsKey)
    }

    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedCategories = try? JSONDecoder().decode(Array<Category>.self, from: jsonData) {
            categories = decodedCategories
        }
    }
    
    let genericInput = Input(name: "What will you name your slider?", InputType: InputType.slider)
    let secondGenericInput = Input(name: "What will you name your counter?", InputType: InputType.intIncrement)
    let thirdGenericInput = Input(name: "Comments", InputType: InputType.textField)
    
    lazy var newTrackables = [genericInput, secondGenericInput, thirdGenericInput]
    
    let testInput = Input(name: "Hours of sleep", InputType: InputType.slider)
    let secondTestInput = Input(name: "Quality of sleep", InputType: InputType.intIncrement)
    let thirdTestInput = Input(name: "Comments?", InputType: InputType.textField)

    let moodInput = Input(name: "How happy are you?", InputType: InputType.slider)
    let secondMoodInput = Input(name: "How tired are you?", InputType: InputType.intIncrement)
    let thirdMoodInput = Input(name: "How excited for the rest of the day are you?", InputType: InputType.textField)
    
    let mealInput = Input(name: "How healthy was the meal?", InputType: InputType.slider)
    let secondMealInput = Input(name: "How much did you eat?", InputType: InputType.intIncrement)
    let thirdMealInput = Input(name: "What did you eat?", InputType: InputType.textField)
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if categories.isEmpty {
            categories = [Category(name: "Day's Meals", trackables: [mealInput, secondMealInput, thirdMealInput], entries: [], id: 0),
                          Category(name: "Sleep", trackables: [testInput, secondTestInput, thirdTestInput], entries: [], id: 1),
                          Category(name: "Mood", trackables: [moodInput, secondMoodInput, thirdMoodInput], entries: [], id: 2)]
        }
    }
    
    // MARK: - Intent
    
    func category(at index: Int) -> Category {
        let safeIndex = min(max(index, 0), categories.count - 1)
        return categories[safeIndex]
    }

    func getIndexOfCategory(category: Category) -> Int {
        var returnIndex: Int = 0;
        for index in 0..<categories.count {
            if categories[index].id == category.id {
                returnIndex = index
            }
        }
        return returnIndex
    }

    @discardableResult
    func removeCategory(at index: Int) -> Int {
        if categories.count > 1, categories.indices.contains(index) {
            categories.remove(at: index)
        }
        return index % categories.count
    }

    func insertCategory(named name: String, trackables: [Input], entries: [Entry], at index: Int = 0) {
        let unique = (categories.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let person = Category(name: name, trackables: trackables, entries: entries, id: unique)
        let safeIndex = min(max(index, 0), categories.count)
        categories.insert(person, at: safeIndex)
    }
}
