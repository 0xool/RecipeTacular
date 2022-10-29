//
//  RecipeList.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/26/22.
//

import SwiftUI

struct RecipeList: View {
    var searchParam: String
    @State private var searchText = ""
    @ObservedObject var recipeModel: RecipeModel
    
    @State private var showFavoritesOnly = false
    
    init(searchParam: String, searchText: String = "") {
        self.searchParam = searchParam
        self.searchText = searchText
        self.recipeModel = RecipeModel()
        
        recipeModel.favRecipesIDs = DataBaseManager.Instance.readRecipeDatas()
        // Load Data based on search Text
        recipeModel.getRecipeListBySearchParams(searchParam)
        
    }
    
    var body: some View {
        ZStack{
            Color.EggShellColor().ignoresSafeArea()
            List{
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(searchResults) { recipe in
                    NavigationLink(destination: NavigationLazyView(RecipeDetail(selectedRecipe: recipe, recipeModel: recipeModel, isFav: recipe.isFav))) {
                        RecipeRow(recipeName: recipe.title, recipeImageName: recipe.image, isFav: recipe.isFav)
                    }
                }
                Button(action: loadMore) {
                                Text("")
                                }
                                .onAppear {
                                    DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                        self.loadMore()
                                    }
                            }
            }
            .searchable(text: $searchText)
            .navigationTitle("Recipes")
        }
        .modifier(Popup(isPresented: recipeModel.showError,
                        content: FailedPopUpView.init))
        .onAppear {
            recipeModel.recipe = nil
        }
    }
    
    var searchResults: [Recipe] {
        var recipes = recipeModel.recipes?.all
        if(showFavoritesOnly){
            recipes =  recipes?.filter({ $0.isFav })
        }
        
        if searchText.isEmpty {
            return recipes ?? []
        } else {
            return recipes?.filter { $0.title.contains(searchText) } ?? []
        }
    }
    
    private func loadMore() {
        recipeModel.getRecipeListBySearchParamsWithOffset(searchParam)
    }
}

struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        RecipeList(searchParam: "bur")
    }
}
