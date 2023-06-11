//
//  ImageClassifier.swift
//  doorianMock
//
//  Created by Warunya on 15/5/2566 BE.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    @Published private var classifier = Classifier()
    @Published var imageClass: String? // Publish the imageClass as a separate property
    
    // MARK: Intent(s)
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage(image: uiImage) else { return }
        classifier.detect(ciImage: ciImage) { [weak self] result in
            self?.imageClass = result // Assign the result to the imageClass property
        }
    }
}
