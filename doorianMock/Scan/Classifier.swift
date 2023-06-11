//
//  Classifier.swift
//  doorianMock
//
//  Created by Warunya on 15/5/2566 BE.
//

import CoreML
import Vision
import CoreImage

struct Classifier {
    private(set) var results: String?
    
    func detect(ciImage: CIImage, completion: @escaping (String?) -> Void) {
        guard let model = try? VNCoreMLModel(for: disease3(configuration: MLModelConfiguration()).model)
        else {
            completion(nil)
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                completion(nil)
                return
            }
            
            if let firstResult = results.first {
                let imageClass = firstResult.identifier
                completion(imageClass)
            } else {
                completion(nil)
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        do {
            try handler.perform([request])
        } catch {
            completion(nil)
        }
    }
}
