//
//  DatabaseManager.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/28/22.
//

import Foundation
import RealmSwift


class DataBaseManager {
    
    static let Instance = DataBaseManager()
    let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func writeRecipeData(recipeID: Int)  {
        let favRecipe = FavRecipe()
        favRecipe.id = recipeID
        if(!favRecipeExist(id: recipeID)){
            realm.beginWrite()
            realm.add(favRecipe)
            try! realm.commitWrite()
        }
    }
    
    func readRecipeDatas() -> [FavRecipe]{
        return Array(realm.objects(FavRecipe.self))
    }
    
    func deleteRecipeData(recipe: FavRecipe) {
        realm.delete(recipe)
    }
    
    func deleteRecipeDataByID(favRecipeID: Int) {
        if(favRecipeExist(id: favRecipeID)){
            try! realm.write {
                let favRecipe = realm.objects(FavRecipe.self).where {
                    $0.id == favRecipeID
                }
                realm.delete(favRecipe)
            }
        }
    }
    
    private func favRecipeExist (id: Int) -> Bool {
        return realm.object(ofType: FavRecipe.self, forPrimaryKey: id) != nil
    }
    
}
