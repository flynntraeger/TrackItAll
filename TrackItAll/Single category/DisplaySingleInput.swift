//
//  DisplaySingleInput.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 07/06/2021.
//
// Displays what was inputted for an entry at the labelled date/time

import SwiftUI

struct DisplaySingleInput: View {
    var entry: Entry

    var body: some View {
        VStack {
            ForEach(entry.entryData, id: \.self) { entryValue in
                VStack {
                    Text(entryValue.name)
                        .foregroundColor(.purple)
                        .fontWeight(.semibold)
                    (entryValue.sliderInput != nil ? Text("\(entryValue.sliderInput ?? 0.0, specifier: "%.1f")"): nil)
                        .font(.subheadline)
                    (entryValue.incrementInput != nil ? Text("\(entryValue.incrementInput ?? 0)"): nil)
                        .font(.subheadline)
                    (entryValue.commentInput != nil ? Text("\(entryValue.commentInput ?? "No Comment Added")"): nil)
                        .font(.subheadline)
                }
                .padding()
            }
        }
    }
}

//struct DisplaySingleInput_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplaySingleInput()
//    }
//}
