//
//  ImageLoader.swift
//  RecipeTacular
//
//  Created by cyrus refahi on 10/27/22.
//

import SwiftUI
import Combine
import Foundation
import AlamofireImage
import Alamofire

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func load() {
        AF.request(url).responseImage { response in
            if case .success(_) = response.result {
                self.image = UIImage(data: response.data!, scale: 1.0)!
            }
        }
    }
    
}
