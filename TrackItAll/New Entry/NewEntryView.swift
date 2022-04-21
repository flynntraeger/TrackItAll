//
//  NewEntryView.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 26/05/2021.
//

import SwiftUI

struct NewEntryView: View {
    @Binding var category: Category
    
    var body: some View {
        VStack {
            ScrollView {
                displayInputs
            }
            .navigationTitle(category.name)
            .navigationBarTitleDisplayMode(.inline)
            addEntryButton
                .padding(.bottom)
        }
    }
    
    @State private var commentToAdd: String = ""
    @State private var sliderValue: Float = 0.0
    @State private var stepperValue: Int = 0
    
    var displayInputs: some View {
        ForEach(category.trackables, id: \.self) { input in
            Section(header: Text(input.name)) {
                (input.InputType == .textField ? enterText() : nil)?
                    .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0))
                (input.InputType == .slider ? slider() : nil)
                (input.InputType == .intIncrement ? stepper() : nil)
            }
            Spacer(minLength: 20)
        }
        .padding()
    }
    
    private func convertToEntry(sliderFloat: Float, stepperInt: Int, comment: String) -> Entry {
        var newEntries: [EntryInput] = []
        var newEntryInput: EntryInput = EntryInput(name: "new", sliderInput: nil, incrementInput: nil, commentInput: nil)
        for trackable in category.trackables {
            if trackable.InputType == .intIncrement {
                newEntryInput = EntryInput(name: trackable.name, sliderInput: nil, incrementInput: stepperInt, commentInput: nil)
            } else if trackable.InputType == .slider {
                newEntryInput = EntryInput(name: trackable.name, sliderInput: sliderFloat, incrementInput: nil, commentInput: nil)
            } else if trackable.InputType == .textField {
                newEntryInput = EntryInput(name: trackable.name, sliderInput: nil, incrementInput: nil, commentInput: comment)
            }
            newEntries.append(newEntryInput)
        }
        return Entry(time: Date(), entryData: newEntries)
    }
    
    private func enterText() -> some View {
        TextField("Add comment...", text: $commentToAdd)
            .modifier(InputBox())
    }
    
    private func slider() -> some View {
        VStack {
            Slider(value: $sliderValue, in: 0...10, step: 0.5)
                .modifier(InputBox())
            let formattedValue = String(format: "%.1f", sliderValue)
            Text("\(formattedValue)")
        }
    }
    
    private func stepper() -> some View {
        Stepper("\(stepperValue)", value: $stepperValue, in: 0...10)
            .modifier(InputBox())
    }
    
    var addEntryButton: some View {
    Button(action: {
        let newEntry = convertToEntry(sliderFloat: sliderValue, stepperInt: stepperValue, comment: commentToAdd)
        print("comment added: \(commentToAdd)")
        category.entries.append(newEntry)
    }) {
        HStack() {
            Text("Add")
            Image(systemName: "icloud.and.arrow.up")
        }
        .modifier(AddButtonFormat())}
    }
}

struct AddButtonFormat: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.purple)
            .padding(7)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color.white)
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
    }
}

struct InputBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(7)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple, lineWidth: 1)
            )
    }
}

//struct NewEntryView_Previews: PreviewProvider {
//    static var categories = CategoriesData().categories
//    static var previews: some View {
//        NewEntryView(category: categories[0])
//    }
//}
