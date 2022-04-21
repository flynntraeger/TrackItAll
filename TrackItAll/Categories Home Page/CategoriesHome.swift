//
//  CategoriesView.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 23/05/2021.
//
// Main homepage view of all categories that have been created

import SwiftUI
import Foundation

struct CategoriesHome: View {
    @EnvironmentObject var categoriesData: CategoryVM
    @Environment(\.presentationMode) var presentationMode
    @State private var editMode: EditMode = .inactive
    @State var showingAlert = false
    
    init() { // Formats titles
            let appearance = UINavigationBarAppearance()
            // only applies to big titles
            appearance.largeTitleTextAttributes = [
                .font : UIFont.systemFont(ofSize: 30.0, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor.purple
            ]
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
    }
    
    func findCategoryCardDestination(category: Category) -> AnyView {
        if editMode.isEditing {
            return AnyView(CategoryEditor(category: $categoriesData.categories[categoriesData.getIndexOfCategory(category: category)]))
        } else {
            return AnyView(DisplayBothViews(category: $categoriesData.categories[categoriesData.getIndexOfCategory(category: category)]))
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                DualVGrid(items: categoriesData.categories, aspectRatio: 3/2) { category in
                        GeometryReader { geometry in
                            ZStack {
                                NavigationLink(destination: findCategoryCardDestination(category: category)) {
                                    CategoryCardView(category: $categoriesData.categories[categoriesData.getIndexOfCategory(category: category)]) //passed as binding so updates instantly
                                        .padding(.init(top: 20, leading: 15, bottom: 0, trailing: 15))
                                }
                                if (editMode == .active) {
                                    deleteCategory
                                        .position(x: geometry.size.width * 0.93 , y: geometry.size.height * 0.1)
                                        .alert(isPresented:$showingAlert) {
                                            checkDeleteAlert(category: category)
                                        } // Deleting a category deletes all past entries, so confirm this with user
                                }
                            }
                        }
                }
                .navigationBarTitle("What are you tracking?")
                .toolbar {
                    ToolbarItem { EditButton() }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if presentationMode.wrappedValue.isPresented,
                           UIDevice.current.userInterfaceIdiom != .pad {
                            Button("Close") {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                categoriesData.insertCategory(named: "New Category", trackables: categoriesData.newTrackables, entries: [])
                            }
                            editMode = .active
                        }, label: {
                            Image(systemName: "plus.circle")
                        })
                    }
                }
                .environment(\.editMode, $editMode)
            }
        }
    }
        
    var deleteCategory: some View {
        Button(action: {
            showingAlert = true
        }) {
            Image(systemName: "minus.circle")
                .imageScale(.large)
                .foregroundColor(.red)
        }
    }
        
    func checkDeleteAlert(category: Category) -> Alert {
        Alert(title: Text("Are you sure you want to delete \(category.name)?"),
              message: Text("This will delete all entries ever made"),
                primaryButton: Alert.Button.default(Text("Delete"), action: {
                    let categoryIndex = categoriesData.getIndexOfCategory(category: category)
                    withAnimation { //says is unused but when removed, deletes are no longer animated 🤷🏽‍♂️
                        categoriesData.removeCategory(at: categoryIndex)
                    }
                }), secondaryButton: Alert.Button.cancel(Text("Cancel"))
            )
    }
}
