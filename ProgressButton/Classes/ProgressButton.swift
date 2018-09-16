import Foundation

//
//  ProgressButton.swift
//  Longines
//
//  Created by Aleksandar Atanackovic on 25.07.18.
//  Copyright © 2018 APPSfactory GmbH. All rights reserved.
//

import UIKit

@IBDesignable
public class ProgressButton: UIButton {

    // MARK: Properties
    
    /// Public property that wraps private progressValue property
    /// Calls stroke action depending on newValue
    @IBInspectable
    public var progress: CGFloat {
        set {
            self.progressValue = newValue
            self.shapelayer?.strokeEnd = CGFloat(newValue)
        }
        get {
            return self.progressValue
        }
    }
    
    /// Corner radius of line around button
    @IBInspectable
    public var cornerRadius: CGFloat = 0 {
        didSet {
            self.shapelayer?.path = self.generatePath()
        }
    }
    
    /// Width of line around button
    @IBInspectable
    public var borderWidth: CGFloat = 1.0 {
        didSet {
            self.shapelayer?.lineWidth = self.borderWidth
        }
    }
    
    /// Color of line around button
    @IBInspectable
    public var lineColor: UIColor = UIColor.black {
        didSet {
            self.shapelayer?.strokeColor = self.lineColor.cgColor
        }
    }
    
    /// Insets for border to prevent overlaping text.
    /// If its set to .zero titleLabel text is really near border line
    @IBInspectable
    public var layerInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: -5) {
        didSet {
            self.updateLayer()
        }
    }
    
    /// Private property that holds value of progress
    private var progressValue: CGFloat = 0
    
    /// Border layer around button
    private var shapelayer: CAShapeLayer?
    
    /// Calculating bounds for shapeLayer path on update of layout or in initialization
    private var calculatedBounds: CGRect {
        if self.layerInsets == .zero {
            return self.bounds
        }
        let newBounds = CGRect(x: self.bounds.origin.x + self.layerInsets.left,
                               y: self.bounds.origin.y + self.layerInsets.top,
                               width: self.bounds.size.width - (self.layerInsets.left * 2) - (self.layerInsets.right * 2),
                               height: self.bounds.size.height - (self.layerInsets.bottom * 2) - (self.layerInsets.top * 2))
        return newBounds
    }
    
    // MARK: Life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    /// Simple method that sets buttons values clipsToBounds and masksToBounds to false so the line can be visible outside of buttons bounds when insets its bigger
    private func configureUI() {
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.updateLayer()
    }
    
    // MARK: UI
    /// Updating layer frame and path to prevent recreating new one
    private func updateLayer() {
        guard self.shapelayer == nil else {
            self.shapelayer?.frame = self.calculatedBounds
            self.shapelayer?.path = self.generatePath()
            return
        }
        self.configureLayer()
    }
    
    /// Reused method for generating same logic for calculated path
    ///
    /// - Returns: path for border of button
    private func generatePath() -> CGPath {
        let b = UIBezierPath(roundedRect: self.calculatedBounds, cornerRadius: self.cornerRadius)
        return b.cgPath
    }
    
    /// Configuring layer only once, on later changes(layoutSubviews) frame is addapted
    private func configureLayer() {
        let layer = CAShapeLayer()
        layer.frame = self.calculatedBounds
        layer.lineWidth = self.borderWidth
        layer.fillColor = nil
        layer.strokeColor = self.lineColor.cgColor
        layer.path = self.generatePath()
        self.layer.addSublayer(layer)
        layer.zPosition = -1
        layer.strokeStart = 0
        layer.strokeEnd = CGFloat(self.progress)
        self.shapelayer = layer
    }
    
    /// Reseting layer without animation
    ///
    /// - Parameter value: Reseting value
    public func reset(to value: CGFloat) {
        self.progressValue = value
        CATransaction.begin()
        CATransaction.setValue(true, forKey: kCATransactionDisableActions)
        self.shapelayer?.strokeEnd = value
        CATransaction.commit()
        
    }
}
