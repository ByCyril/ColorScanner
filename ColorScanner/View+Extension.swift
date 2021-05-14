//
//  View+Extension.swift
//  ColorScanner
//
//  Created by Cyril Garcia on 5/14/21.
//

import UIKit

extension UIView {
    
    func colorOfPoint (point: CGPoint) -> [Int]
      {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        guard let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else { return [] }

        context.translateBy(x: -point.x, y: -point.y)
        self.layer.render(in: context)
     
        return [Int(pixel[0]),Int(pixel[1]),Int(pixel[2])]
      }
}
