//
//  DisplayCategoryData.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 07/06/2021.
//

import SwiftUI

struct DisplayCategoryData: View {
    @Binding var category: Category
    
    var body: some View {
        Group {
            if category.entries.isEmpty {
                ScrollView {
                    VStack {
                        Spacer()
                        Text(" \(Image(systemName: "xmark.rectangle")) No entries yet \(Image(systemName: "xmark.rectangle"))")
                        Text("\(Image(systemName: "hand.point.left.fill")) Swipe left to create one!")
                            .padding()
                    }
                    .foregroundColor(.purple)
                }
            } else {
                List(category.entries, id: \.self) { entry in
                    NavigationLink(destination: DisplaySingleInput(entry: entry)) {
                        Text(dateFormatter.string(from: entry.time))
                    }
                }
            }
        }
    }
}

var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "E, d MMM y - HH:mm"
    return formatter
}

//struct DisplayCategoryData_Previews: PreviewProvider {
//
//    static var previews: some View {
//        DisplayCategoryData()
//    }
//}
