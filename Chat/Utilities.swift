//
//  Utilities.swift
//  ChatBot
//
//  Created by Arpit Lokwani on 19/01/21.
//  Copyright © 2021 Arpit Lokwani. All rights reserved.
//


import UIKit

// MARK: - UIView
extension UIView {

    func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
    func edges(_ edges: UIRectEdge, to layoutGuide: UILayoutGuide, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
}
