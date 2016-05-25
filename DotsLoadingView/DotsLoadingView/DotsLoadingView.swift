//
//  DotsLoadingView.swift
//  DotsLoadingView
//
//  Created by zhangyi on 16/5/25.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

import UIKit

let dotWidth: CGFloat = 10.0

class DotsLoadingView: UIView {

    let colors = [UIColor(red:0.23, green:0.27, blue:0.76, alpha:1), UIColor(red:1, green:0.77, blue:0.02, alpha:1), UIColor(red:1, green:0.32, blue:0.33, alpha:1)]
    
    override init(frame: CGRect) {
        let size = CGSize(width: 6 * dotWidth, height: 2 * dotWidth)
        let rect = CGRect(origin: frame.origin, size: size)
        super.init(frame: rect)
        
        var num = 0
        
        let animatorDots = colors.flatMap { (color) -> CALayer in
            let layer = CALayer()
            layer.bounds = CGRect(x: 0, y: 0, width: dotWidth, height: dotWidth)
            layer.backgroundColor = color.CGColor
            layer.position = CGPoint(x: dotWidth * CGFloat((num * 2 + 1)), y: dotWidth)
            layer.cornerRadius = dotWidth / 2
            self.layer .addSublayer(layer)
            num += 1
            
            return layer
        }
        
        num = 0
        for layer in animatorDots {
            let keyAnimation = CAKeyframeAnimation(keyPath: "transform")
            keyAnimation.duration = 1.5
            keyAnimation.removedOnCompletion = false
            keyAnimation.repeatCount = MAXFLOAT
            
            var baseValues = [NSValue]()
            for _ in 0..<4 {
                baseValues.append(NSValue(CATransform3D: CATransform3DIdentity))
            }
            
            baseValues.insert(NSValue(CATransform3D: CATransform3DMakeScale(1.5, 1.5, 1)), atIndex: num + 1)
            num += 1
            keyAnimation.values = baseValues
            keyAnimation.calculationMode = kCAAnimationLinear
            layer.addAnimation(keyAnimation, forKey: "animationKey")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
