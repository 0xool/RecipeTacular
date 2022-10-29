//
//  PopUp.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/28/22.
//

import SwiftUI

struct Popup<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool
    let alignment: Alignment

    init(isPresented: Bool, alignment: Alignment = .bottom, @ViewBuilder content: () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        popup = content()
    }

    func body(content: Content) -> some View {
        content
            .overlay(popupContent())
    }

    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup
                    .animation(.spring())
                    .transition(.offset(x: 0, y: geometry.belowScreenEdge))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment) // (*)
            }
        }
    }
}

struct  FailedPopUpView: View {
    
    var body: some View {
        ZStack{
             Color.red.frame(width: UIScreen.screenWidth * 0.8, height: 50).cornerRadius(10)
            Text("Network Request Failed")
        }
    }
    
}

private extension GeometryProxy {
    var belowScreenEdge: CGFloat {
        UIScreen.main.bounds.height - frame(in: .global).minY
    }
}


