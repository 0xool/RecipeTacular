//
//  RecipeTacularTests.swift
//  RecipeTacularTests
//
//  Created by cyrus refahi on 10/26/22.
//

import XCTest
@testable import RecipeTacular

final class RecipeTacularTests: XCTestCase {
    
    var sut: RecipeTacular!
    var dbManagerSut: DataBaseManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = RecipeTacular()
        dbManagerSut = DataBaseManager()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }
    
    
    func testDatabaseSaveTheCorrectData() throws {
        dbManagerSut.writeRecipeData(recipeID: 10)
        let expected = FavRecipe()
        expected.id = 10
        
        let values = dbManagerSut.readRecipeDatas()
        let result = values[values.count - 1].id
        
        XCTAssertEqual(result, expected.id, "Database value is wrong!")
        
        dbManagerSut.deleteRecipeDataByID(favRecipeID: 10)
    }
    
    func testRecipesJsonParsesCorectly() throws {
        let json = """
        {
            "offset": 0,
            "number": 2,
            "results": [
                {
                    "id": 716429,
                    "title": "Pasta with Garlic, Scallions, Cauliflower & Breadcrumbs",
                    "image": "https://spoonacular.com/recipeImages/716429-312x231.jpg",
                    "imageType": "jpg",
                },
                {
                    "id": 715538,
                    "title": "What to make for dinner tonight?? Bruschetta Style Pork & Pasta",
                    "image": "https://spoonacular.com/recipeImages/715538-312x231.jpg",
                    "imageType": "jpg",
                }
            ],
            "totalResults": 86
        }
    """
        let jsonData = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let recipes = try decoder.decode(Recipes.self, from: jsonData)
            let expectedValue: Int = 716429
            XCTAssertEqual(recipes.all[0].id, expectedValue)

        } catch {
            XCTAssertThrowsError("Could not decode")
        }
    }
    
    func testRecipeJsonParsesCorectly() throws {
        let json = Constants.JSONExample().recipe
        let jsonData = Data(json.utf8)
        let decoder = JSONDecoder()

        do {
            let recipe = try decoder.decode(Recipe.self, from: jsonData)
            let expectedValue: Int = 716429
            XCTAssertEqual(recipe.id, expectedValue)

        } catch {
            
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
