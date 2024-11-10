//
//  ProgressView.swift
//  Refactoring
//
//  Created by Nikolay Shishkin on 06/11/2024.
//

import UIKit

class ProgressView: UIView {
    var step: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var stepCount: Int = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var activeColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    var notActiveColor: UIColor = UIColor.white.withAlphaComponent(0.35) {
        didSet {
            setNeedsDisplay()
        }
    }
    var gapWidth: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    var progress: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
      let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.clear.cgColor)
        context?.fill(rect)

        if stepCount > 0 {
            let oneStepWidth = (rect.width - gapWidth * CGFloat(stepCount - 1)) / CGFloat(stepCount)
            for i in 0...stepCount {
                let positionX = (oneStepWidth + gapWidth) * CGFloat(i)
                if i != step {
                    if i < step {
                        context?.setFillColor(activeColor.cgColor)
                        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: 0, width: oneStepWidth, height: rect.height), cornerRadius: rect.height / 2)
                        bezierPath.fill()
                    } else {
                        context?.setFillColor(notActiveColor.cgColor)
                        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: 0, width: oneStepWidth, height: rect.size.height), cornerRadius: rect.height / 2)
                        bezierPath.fill()
                    }
                }
            }
            
            let positionX = (oneStepWidth + gapWidth) * CGFloat(step)
            let stepRect = CGRect(x: positionX, y: 0, width: oneStepWidth, height: rect.height)
            context?.setFillColor(notActiveColor.cgColor)
            let bezierPath = UIBezierPath(roundedRect: stepRect, cornerRadius: rect.height / 2)
            bezierPath.fill()
            
            let progressWidth = progress * oneStepWidth
            context?.setFillColor(activeColor.cgColor)
            let bezierPathProgress = UIBezierPath(roundedRect: CGRect(x: positionX, y: 0, width: progressWidth, height: rect.height), cornerRadius: rect.height / 2)
            bezierPath.addClip()
            bezierPathProgress.addClip()
            context?.fill(stepRect)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
    }
}
