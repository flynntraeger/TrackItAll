//
//  DisplayDataView.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 07/06/2021.
//

// Controls the switching between the two views held in a
// tabview that are displayed when a category is tapped on while
// not in edit mode.
// I learned the tabview method from:
// https://www.hackingwithswift.com/quick-start/swiftui/adding-tabview-and-tabitem
// And I got the basis for the gesture from:
// https://plankenau.com/blog/post/swipeable-tabview-swiftui

import SwiftUI

struct DisplayBothViews: View {
    @State private var pickerSelectedItem = 0
    @Binding var category: Category
    
    let numTabs = 2
    let minDragTranslationForSwipe: CGFloat = 50
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        TabView(selection: $pickerSelectedItem) {
            NewEntryView(category: $category)
                .tabItem {
                    Label("New entry", systemImage: "folder.badge.plus")
                }
                .tag(0)
                .gesture(
                    DragGesture()
                        .onEnded({ self.handleSwipe(translation: $0.translation.width)})
                )
                .animation(.easeIn)
            DisplayCategoryData(category: $category)
                .tabItem {
                    Label("Past entries", systemImage: "list.bullet")
                }
                .tag(1)
                .gesture(
                    DragGesture()
                        .onEnded({ self.handleSwipe(translation: $0.translation.width)})
                )
                .animation(.spring())
        }
        .navigationTitle("\(category.name)")
    }
    
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && pickerSelectedItem > 0 {
            pickerSelectedItem -= 1
        } else if translation < -minDragTranslationForSwipe && pickerSelectedItem < numTabs-1 {
            pickerSelectedItem += 1
        }
    }
}

//struct DisplayDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayDataView()
//    }
//}
