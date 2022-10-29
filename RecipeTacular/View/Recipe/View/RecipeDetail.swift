//
//  RecipeDetail.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/26/22.
//

import SwiftUI
import WebKit

struct RecipeDetail: View {
    var cachedRecipeData: Recipe
    var isFav: Bool
    @ObservedObject var recipeModel: RecipeModel
    
    init(selectedRecipe: Recipe, recipeModel: RecipeModel, isFav: Bool) {
        self.cachedRecipeData = selectedRecipe
        self.recipeModel = recipeModel
        self.isFav = isFav
    }
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImageView(url: URL(string: self.cachedRecipeData.image)!)
                HStack(alignment: .center){
                    ZStack{
                        Rectangle()
                            .cornerRadius(20)
                            .foregroundColor(Color.BtnPinkColor())
                            .frame(width: UIScreen.screenWidth * 0.5, height: 35)
                        Text(cachedRecipeData.title)
                            .font(.title2)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .shadow( color: .black ,radius: 1)
                    }
                    .offset(x:50)
                    Button {
                        if(!self.recipeModel.recipe!.isFav) {
                            recipeModel.addRecipeToFav(recipeID: cachedRecipeData.id)
                        }else{
                            recipeModel.removeRecipeToFav(recipeID: cachedRecipeData.id)
                        }
                        
                        self.recipeModel.recipe!.isFav = !self.recipeModel.recipe!.isFav
                    } label: {
                        if (self.recipeModel.recipe?.isFav == true) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .frame(width: 100, height: 100)
                        }else{
                            Image(systemName: "star.fill")
                                .foregroundColor(.gray)
                                .frame(width: 100, height: 100)
                        }
                    }
                    .offset(x:25)

                    
                }
                ZStack{
                    InfoView(preperationTime: recipeModel.recipe?.readyInMinutes, healthScore: recipeModel.recipe?.healthScore)
                        .padding(.leading, 8)
                        .padding(.trailing, 8)
                }
                
                ZStack{
                    Rectangle()
                        .cornerRadius(15)
                        .foregroundColor(.gray)
                        .opacity(0.1)
                    VStack{
                        Text((recipeModel.recipe?.instructions == nil) ? "" : "Summary")
                            .font(.title)
                        Text(recipeModel.recipe?.summary ?? "")
                    }.padding(8)
                }
                .padding(8)
                
                ZStack{
                    Rectangle()
                        .cornerRadius(15)
                        .foregroundColor(.gray)
                        .opacity(0.1)
                    VStack{
                        Text((recipeModel.recipe?.instructions == nil) ? "" : "Instructions" )
                            .font(.title)
                        Text(recipeModel.recipe?.instructions ?? "")
                    }.padding(8)
                }
                .padding(8)

                Spacer()
            }.onAppear {
                getRecipeDetail()
            }
            .offset(y: UIScreen.main.bounds.height * -0.13)
        }
    }
    
    private func getRecipeDetail() {
        recipeModel.getRecipeBeID(self.cachedRecipeData.id)
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}

struct InfoView: View {
    var preperationTime: Int?
    var healthScore: Int?
    
    var body: some View{
        Group{
            HStack{
                infoText(title: "preperationTime: ", desc: "\(self.preperationTime ?? 0 )" )
                Spacer()
                HStack(alignment: .center){
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .offset(x:5)
                        Text("\(self.healthScore ?? 0)")
                    
                }
            }
        }
    }
    
    func infoText(title: String, desc: String) -> some View {
        return HStack(alignment: .center){
            Text(title)
                .bold()
            + Text(desc)
        }
    }
}

struct RecipeIngridientsView: View {
    var body: some View{
        GroupBox{
            
        }
    }
}

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    
    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable(resizingMode: .stretch)
                    .ignoresSafeArea()
                    .frame(height: 300)
                
            } else {
                Image(systemName: "placeholdertext.fill")
            }
        }
    }
    
}

//struct RecipeDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        //RecipeDetail(selectedRecipe: recipeModel: RecipeModel())
//    }
//}
