//
//  DotsLoadingView.swift
//  DotsLoadingView
//
//  Created by zhangyi on 16/5/25.
//  Copyright © 2016年 Hikvision. All rights reserved.
//

import UIKit

class DotsLoadingView: UIView {
    
    private lazy var dotsColors = [UIColor(red:0.23, green:0.27, blue:0.76, alpha:1), UIColor(red:1, green:0.77, blue:0.02, alpha:1), UIColor(red:1, green:0.32, blue:0.33, alpha:1)]
    private lazy var dotsLayers: [CALayer] = {
        return self.createLayers()
    }()
    
    var dotWidth: CGFloat = 10 {
        didSet {
            self.adjustFrame()
        }
    }
    private var isLoading = false
    
    
    override init(frame: CGRect) {
        
        let size = CGSize(width: 6 * dotWidth, height: 2 * dotWidth)
        let rect = CGRect(origin: frame.origin, size: size)
        super.init(frame: rect)
        
        for dotLayer in dotsLayers {
            layer.addSublayer(dotLayer)
        }
        
        adjustFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func adjustFrame() {
        let center = self.center
        self.frame.size = CGSize(width: 6 * dotWidth, height: 2 * dotWidth)
        
        for i in 0..<dotsLayers.count {
            let dotLayer = dotsLayers[i]
            
            dotLayer.bounds = CGRect(x: 0, y: 0, width: dotWidth, height: dotWidth)
            dotLayer.position = CGPoint(x: dotWidth * (CGFloat(i) * 2.0 + 1.0), y: dotWidth)
            dotLayer.cornerRadius = dotWidth / 2
        }
        
        self.center = center
    }
    
    private func createLayers() -> [CALayer] {
        let layers = self.dotsColors.map({ (color) -> CALayer in
            let layer = CALayer()
            layer.backgroundColor = color.CGColor
            layer.cornerRadius = dotWidth / 2
            return layer
        })
        
        return layers
    }
}

// MARK: - Public Method
extension DotsLoadingView {
    /**
     设置dot的颜色
       默认3种颜色 (0.23, 0.27, 0.76) (1, 0.77, 0.02) (1, 0.32, 0.33)
     - parameter color: dot待设置的颜色
     - parameter index: dot所在位置 0..<3
     */
    func setDotsColor(color: UIColor, index: Int) {
        guard index > 0 && index < 3 else {
            return;
        }
        
        dotsColors[index] = color
        let dotLayer = dotsLayers[index]
        dotLayer.backgroundColor = color.CGColor
    }
    
    func loading() -> Bool {
        return isLoading
    }
    
    func startLoading() {
        
        if loading() {
            return;
        }
        
        var num = 0
        
        isLoading = true
        
        for layer in dotsLayers {
            
            layer.removeAllAnimations()
            
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
    
    func stopLoading() {
        if !loading() {
            return
        }
        
        isLoading = false
        
        for layer in dotsLayers {
            layer.removeAllAnimations()
            layer.transform = CATransform3DIdentity
        }
    }
}