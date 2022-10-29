//
//  RecipeRow.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/26/22.
//

import SwiftUI

struct RecipeRow: View {
    var recipeName: String
    var recipeImageName: String
    var isFav: Bool
    var url: URL?
    
    init(recipeName: String, recipeImageName: String, isFav: Bool) {
        self.recipeName = recipeName
        self.recipeImageName = recipeImageName
        self.isFav = isFav
        
        url = URL(string: recipeImageName)
    }
    
    
    var body: some View {
        ZStack{
            HStack{
                AsyncImage(url: self.url!)
                    .aspectRatio(contentMode: .fit)
                
                Text(recipeName)
                    .font(.headline)
                Spacer()
                
                if self.isFav {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }
                
            }.foregroundColor(.black)
                .padding(8)
        }
    }
}

struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        RecipeRow(recipeName: "Mango", recipeImageName: "https://spoonacular.com/recipeImages/636461-312x231.jpg",isFav: true)
            .previewLayout(.fixed(width: 300, height: 70))
    }
    
}
