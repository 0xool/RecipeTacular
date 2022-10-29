//
//  Recipe.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/26/22.
//

import Foundation
import RealmSwift

class FavRecipe: Object {
    @Persisted(primaryKey: true) var id: Int
}

struct Recipe: Identifiable, Decodable {
    var id: Int
    
    var isFav: Bool = false
    var title: String
    var image: String
    
    var imageType: String
    //    var servings: Int?
    var readyInMinutes: Int?
    //
    //    var license: String?
    //    var sourceName: String?
    //    var sourceUrl: String?
    //
    //    var spoonacularSourceUrl: String?
    var healthScore: Int?
    //
    //    var spoonacularScore: Int?
    //    var pricePerServing: Int?
    //    //var analyzedInstructions: [String]
    //
    var cheap: Bool?
    //    var creditsText: String?
    //    var cuisines: [String]?
    //
    //    var dairyFree: Bool?
    //    var diets: [String]?
    //    var gaps: String?
    //
    //    var glutenFree: Bool?
    var instructions: String?
    var summary: String?
    //    var ketogenic: Bool?
    //
    //    var lowFodmap: Bool?
    //    var occasions: [String]?
    //    var sustainable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case image
        
        case imageType
        case healthScore
        case readyInMinutes
        
        case cheap
        case summary
        
        case instructions
    }
}


struct Recipes: Decodable {
    var all: [Recipe] 
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}
