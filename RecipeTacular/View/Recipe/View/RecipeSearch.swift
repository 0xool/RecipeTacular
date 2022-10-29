//
//  RecipeSearch.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/27/22.
//

import SwiftUI

struct RecipeSearch: View {
    @State private var searchParam: String = ""
    @State private var editing = false
    @State private var opacity: Double = 0
    
    @State private var mainIconOffset: CGFloat = 100
    @State private var mainIconScale: Double = 1.3
    
    init() {

    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.EggShellColor().ignoresSafeArea()
                VStack{
                    Image("RecipeIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: UIScreen.screenHeight * 0.2)
                        .offset(y:mainIconOffset)
                        .scaleEffect(mainIconScale)
                    VStack(alignment: .center) {
                        
                        Text("What kind of recipe are you looking for?")
                            .offset(y: 10)
                        TextField("Search For Recipe", text: $searchParam) {self.editing = $0}
                            .textFieldStyle(SearchTextFieldStyle(focused: $editing))
                        searchButton
                            .padding(10)
                    }
                    .opacity(opacity)
                }
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.async {
                withAnimation (.easeIn(duration: 3).delay(3)) {
                    self.mainIconScale = 1
                    self.mainIconOffset = -50
                }
                withAnimation (.easeIn(duration: 1).delay(5)) {
                    self.opacity = 1
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    
    var searchButton: some View {
        NavigationLink(destination: NavigationLazyView(RecipeList(searchParam: searchParam))) {
            
            ZStack{
                Rectangle()
                    .cornerRadius(15)
                    .foregroundColor(Color(red: 244/255, green: 65/255, blue: 116/255))
                    .frame(height: 75)
                
                Text("Search")
                    .foregroundColor(.white)
                    .font(.title)
            }.offset(y: -20)
        }
    }
    
    private func getRecipe() {
        
    }
}

struct SearchTextFieldStyle: TextFieldStyle {
    @Binding var focused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(focused ? Color.SpaceCadetColor() : Color.gray, lineWidth: 3)
            ).padding()
    }
}

struct RecipeSearch_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearch()
    }
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
