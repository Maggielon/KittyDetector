//
//  ViewModel.swift
//  KittyDetector
//
//  Created by Анастасия on 17.12.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation
import Vision

class ViewModel {
    
    private let model = KittyObjectDetector()
    var request: VNCoreMLRequest?
    private var visionModel: VNCoreMLModel?
    
    func setup(completion: @escaping (_ results: [Any]) -> Void) {
        if let visionModel = try? VNCoreMLModel(for: self.model.model) {
            self.visionModel = visionModel
            self.request = VNCoreMLRequest(model: visionModel) { request, error in
                DispatchQueue.main.async(execute: {
                    if let results = request.results {
                        completion(results)
                    }
                })
            }
        }
    }
}
