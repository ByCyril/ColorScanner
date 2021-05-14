//
//  ViewController.swift
//  ColorScanner
//
//  Created by Cyril Garcia on 5/13/21.
//

import UIKit
import CoreML

class ViewController: UIViewController,
                      UINavigationControllerDelegate,
                      UIImagePickerControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var colorLabels: UILabel!
    @IBOutlet var colorViewer: UIView!
    
    let colorPredictor = ColorPredictor()
    let imagePicker = UIImagePickerController()
    
    let pointer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.layer.cornerRadius = 25
        view.alpha = 0.15
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pointer)
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let img = info[.originalImage] as? UIImage else { return }
        
        imageView.image = img
        
        picker.dismiss(animated: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let pos = touch.location(in: imageView)
        let rgb = imageView.colorOfPoint(point: pos)
        
        pointer.frame.origin = touch.location(in: view)
        colorViewer.backgroundColor = UIColor(red: CGFloat(rgb[0]) / 255,
                                              green: CGFloat(rgb[1]) / 255,
                                              blue: CGFloat(rgb[2]) / 255,
                                              alpha: 1)
        
        colorPredictor.predict(vals: rgb) { [weak colorLabels] color in
            colorLabels?.text = color
        }
        
    }
    
    @IBAction func selectImage() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
}
