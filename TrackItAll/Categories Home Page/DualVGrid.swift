//
//  AspectVGrid.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 23/05/2021.
//
// This 'DualVGrid' is quite obviously an adaptation of the AspectVGrid from class.
// Here I adapted it to be able to work in tandem with my CategoryCardView to display
// The exact shape I had envisioned for this app's homepage right from the start of this
// project, and also manipulated them both to format other things, like the delete category
// button, as nicely as possible.

import SwiftUI

struct DualVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item] 
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                LazyVGrid(columns: [adaptiveGridItem(width: 140)], spacing: 0) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum:width))
        gridItem.spacing = 0
        return gridItem
    }
}
