//
//  CrossFadeValueSlider.swift
//  AudioPlayer
//
//  Created by Сергей Горячев on 26.04.2022.
//

import Foundation
import UIKit

class CrossFadeValueSlider {
    
    static let slider = UISlider()
    
    static func setupSlider(view: UIView) {
        slider.frame = CGRect(x: 100, y: 400, width: 200, height: 50)
        
        slider.minimumValue = 2
        slider.maximumValue = 10
        slider.value = 5
        
        slider.thumbTintColor = UIColor.red
        
        slider.minimumTrackTintColor = UIColor.yellow
        slider.maximumTrackTintColor = UIColor.brown
                
        slider.isContinuous = false
        
        view.addSubview(slider)
    }
}
