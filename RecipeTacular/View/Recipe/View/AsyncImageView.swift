//
//  AsyncImageView.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/27/22.
//

import Foundation
import Combine
import SwiftUI

struct AsyncImage: View {
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
                    .resizable()
                    .frame(width: 50,height: 50)
                    .cornerRadius(15)
                
            } else {
                Image(systemName: "placeholdertext.fill")
            }
        }
    }
    
}
