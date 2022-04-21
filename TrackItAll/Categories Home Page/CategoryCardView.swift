//
//  CategoryCardView.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 05/06/2021.
//
// This view creates the cardview used in the Categories Homepage

import SwiftUI

struct CategoryCardView: View {
    @Binding var category: Category
    
    var body: some View {
        ZStack {
            CardView(corners: [.topLeft,
                               .topRight,
                               .bottomLeft,
                               .bottomRight], radius: 10)
                .fill(Color(.purple))
            //This shape was created in this way as I originally only wanted 2 corners rounded, but later changed my mind
            VStack {
                Text(category.name)
                    .font(.system(size: 25))
                    .foregroundColor(.white)
            }
        }
    }
}

struct CardView: Shape, Animatable {
    let corners: UIRectCorner
    let radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

//struct CircleImage_Previews: PreviewProvider {
//    static var categories = CategoriesData().categories
//    static var previews: some View {
//        CategoryCardView(category: categories[0])
//    }
//}
