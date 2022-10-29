//
//  RecipeModel.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/27/22.
//

import Foundation
import Alamofire


public class RecipeModel: ObservableObject {
    @Published var recipes: Recipes?
    @Published var recipe: Recipe?
    @Published var showError: Bool = false
    
    @Published var favRecipesIDs: [FavRecipe] = []
    private var offset = 0
    var selectedRecipeDetailID: Int? = nil
    
    init() {
        self.recipes = nil
        self.recipe = nil
    }
    
    func addRecipeToFav(recipeID: Int)  {
        DataBaseManager.Instance.writeRecipeData(recipeID: recipeID)
        var favRecipe = FavRecipe()
        favRecipe.id = recipeID
        
        self.favRecipesIDs.append(favRecipe)
        if let row = self.recipes?.all.firstIndex(where: {$0.id == recipeID}) {
            recipes?.all[row].isFav = true
        }
    }
    
    func removeRecipeToFav(recipeID: Int)  {
        DataBaseManager.Instance.deleteRecipeDataByID(favRecipeID: recipeID)
        favRecipesIDs = []
        if let row = self.recipes?.all.firstIndex(where: {$0.id == recipeID}) {
            recipes?.all[row].isFav = false
        }
    }
    
    func getRecipeBeID(_ id: Int)  {
        let params = [ "apiKey": Constants.apiKey] as [String : Any]
        NetworkManager.GetRequest(decoderModel: Recipe.self, params: params, successHandler: { response in
            guard var value = response.value else { return }
            value.isFav = self.favRecipesIDs.contains(where: {$0.id == value.id})
            self.recipe = value
        }, failedHandler: {
            print($0)
        }, url: Constants.CreateGetRecipeInformationUrl(id: id))
        
    }
    
    func getRecipeListBySearchParams(_ searchParams: String)  {
        let params = ["query":searchParams, "apiKey": Constants.apiKey] as [String : Any]
        NetworkManager.GetRequest(decoderModel: Recipes.self, params: params, successHandler: { response in
            guard var values = response.value else { return }
            for index in 0..<values.all.count{
                values.all[index].isFav = self.favRecipesIDs.contains(where: { $0.id ==  values.all[index].id})
            }
            self.recipes = values
        }, failedHandler: { res in
            self.showErrorMessage()
            print(res)
        }, url: Constants.GetRecipeWithComplexSearch)
    }
    
    func getRecipeListBySearchParamsWithOffset(_ searchParams: String)  {
        offset += 10
        let params = ["query":searchParams, "apiKey": Constants.apiKey, "offset":offset] as [String : Any]
        NetworkManager.GetRequest(decoderModel: Recipes.self, params: params, successHandler: { response in
            guard var values = response.value else { return }
            for index in 0..<values.all.count{
                values.all[index].isFav = self.favRecipesIDs.contains(where: { $0.id ==  values.all[index].id})
            }
            
            self.recipes?.all.append(contentsOf: values.all)
        }, failedHandler: { res in
            self.showErrorMessage()
            print(res)
        }, url: Constants.GetRecipeWithComplexSearch)
    }
    
    private func showErrorMessage() {
        self.showError.toggle()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            self.showError.toggle()
        }
    }
    
}
