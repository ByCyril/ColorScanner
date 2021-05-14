//
//  RGB.swift
//  ColorScanner
//
//  Created by Cyril Garcia on 5/14/21.
//

import Foundation
import CoreML

final class RGB: MLMultiArray {
    
    init?(_ rgb: [Int]) {
        try? super.init(shape: [1,3], dataType: .int32)
        self[0] = NSNumber(value: rgb[0])
        self[1] = NSNumber(value: rgb[1])
        self[2] = NSNumber(value: rgb[2])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLMultiArray {
    func maxIndex() -> Int {
        
        var maxVal: Float = -1
        var maxIndex = -1
        
        for i in 0..<self.count {
            let val = Float(truncating: self[i])
            if val > maxVal {
                maxVal = val
                maxIndex = i
            }
        }
        
        return maxIndex
    }
}
