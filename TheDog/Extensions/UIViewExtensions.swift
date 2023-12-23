//
//  UIViewExtensions.swift
//  TheDog
//
//  Created by Lokesh on 12/21/23.
//

import Foundation
import UIKit

public extension UIView {

  func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?, width: CGFloat, height: CGFloat)
    {
      translatesAutoresizingMaskIntoConstraints = false
      if let top = top {
        topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
      }
      if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
      }
      if let right = right {
        //rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        trailingAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
      }
      if let left = left {
        //leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        leadingAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
      }
      if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
      }
      if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
      }
      if let centerX = centerX {
        centerXAnchor.constraint(equalTo: centerX).isActive = true
      }
      if let centerY = centerY {
        centerYAnchor.constraint(equalTo: centerY).isActive = true
      }
    }
    
    func addDropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.cornerRadius = 4
    }
}
