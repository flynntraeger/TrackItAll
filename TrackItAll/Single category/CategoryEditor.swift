//
//  CategoryEditor.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 23/05/2021.
//

import SwiftUI

struct CategoryEditor: View {
    @Binding var category: Category
    
    var body: some View {
        Form {
            nameSection
            sliderSection
            intIncrementSection
            commentSection
        }
        .navigationTitle("Edit \(category.name)")
        .frame(minWidth: 300, minHeight: 350)
    }
        
    var nameSection: some View {
        Section(header: Text("Name")) {
            HStack {
                TextField("Name", text: $category.name)
                if category.name.count != 0 {
                        Button(action: {
                            category.name = ""
                        }) {
                            Image(systemName: "delete.left")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        }
                        .padding(.leading, 5)
                    }
            }
        }
    }
    
    var sliderSection: some View {
        Section(header: Text("Slider Input")) {
            HStack {
                TextField("Name", text: $category.trackables[0].name)
                if category.name.count != 0 { //As I'm always creating new categories with something in the textfield, I provided an easy way to delete all of it at once
                        Button(action: {
                            category.trackables[0].name = ""
                        }) {
                            Image(systemName: "delete.left")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        }
                        .padding(.leading, 5)
                    }
            }
        }
    }
    
    var intIncrementSection: some View {
        Section(header: Text("Number picker")) {
            HStack {
                TextField("Enter", text: $category.trackables[1].name)
                if category.name.count != 0 {
                        Button(action: {
                            category.trackables[1].name = ""
                        }) {
                            Image(systemName: "delete.left")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        }
                        .padding(.leading, 5)
                    }
            }
        }
    }
    
    var commentSection: some View {
        Section(header: Text("Comment section")) {
            HStack {
                TextField("Comment section", text: $category.trackables[2].name)
                if category.name.count != 0 {
                        Button(action: {
                            category.trackables[2].name = ""
                        }) {
                            Image(systemName: "delete.left")
                                .foregroundColor(Color(UIColor.opaqueSeparator))
                        }
                        .padding(.leading, 5)
                    }
            }
        }
    }
    
}
