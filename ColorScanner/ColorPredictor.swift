//
//  ColorPredictorManager.swift
//  ColorScanner
//
//  Created by Cyril Garcia on 5/14/21.
//

import Foundation
import CoreML

final class ColorPredictor {
    
    var model: ColorModel?
    let colors = ["Black", "Yellow", "Orange", "Brown", "Blue", "Purple","White", "Pink", "Grey", "Green", "Red"]

    init() {
        do {
            model = try ColorModel(configuration: .init())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func predict(vals: [Int], completion: (String) -> Void) {
        guard let model = model else { return }
        guard let rgb = RGB(vals) else { return }
        
        do {
            
            let input = ColorModelInput(dense_input: rgb)
            let pred = try model.prediction(input: input)
            let c = pred.Identity.maxIndex()

            completion(colors[c])
            
        } catch {
            print(error.localizedDescription)
        }
    }
  
}
