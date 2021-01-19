//
//  InputTextView.swift
//  ChatBot
//
//  Created by Arpit Lokwani on 19/01/21.
//  Copyright © 2021 Arpit Lokwani. All rights reserved.
//

import UIKit

@objc protocol InputTextViewDelegate: class {
    func didPressSendButton(_ text: String, _ sender: UIButton, _ textView: UITextView)
    @objc optional func didPressAddMoreButton(_ sender: UIButton)
    @objc optional func didPressCameraButton(_ sender: UIButton)
    @objc optional func didPressMicButton(_ sender: UIButton)
}

class InputTextView: UIView {
    
    weak var delegate: InputTextViewDelegate?
    
    static let textViewHeight: CGFloat = 34
    
    static let buttonItemHeight: CGFloat = 44
    
    var textViewHeightConstraint: NSLayoutConstraint!
    
    var leftStackViewWidthConstraint: NSLayoutConstraint!
    
    var rightStackViewWidthConstraint: NSLayoutConstraint!
    
    var textView: UITextView = {
        let v = UITextView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var firstRightButton = UIButton()
    
    var secondRightButton = UIButton()
    
    var leftStackView: UIStackView = {
        let v = UIStackView()
        v.axis = NSLayoutConstraint.Axis.horizontal
        v.spacing = 0
        v.distribution = .fillEqually
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var rightStackView: UIStackView = {
        let v = UIStackView()
        v.axis = NSLayoutConstraint.Axis.horizontal
        v.spacing = 0
        v.distribution = .fillEqually
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let padding: CGFloat = 8
        let buttonPadding: CGFloat = 3
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        self.addSubview(textView)
        textView.edges([.bottom, .top], to: self, offset: .init(top: padding, left: padding, bottom: -padding, right: -padding))
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: InputTextView.textViewHeight)
        textViewHeightConstraint.isActive = true
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        textView.layer.cornerRadius = InputTextView.textViewHeight/2
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        
        self.addSubview(leftStackView)
        leftStackView.edges([.left, .bottom], to: self, offset: .init(top: buttonPadding, left: buttonPadding, bottom: -buttonPadding, right: -buttonPadding))
        leftStackView.trailingAnchor.constraint(equalTo: textView.leadingAnchor, constant: -buttonPadding).isActive = true
        leftStackViewWidthConstraint = leftStackView.widthAnchor.constraint(equalToConstant: 0)
        leftStackViewWidthConstraint.isActive = true
        leftStackView.heightAnchor.constraint(equalToConstant: InputTextView.buttonItemHeight).isActive = true
        setupLeftBarItems()
        
        self.addSubview(rightStackView)
        rightStackView.edges([.right, .bottom], to: self, offset: .init(top: buttonPadding, left: buttonPadding, bottom: -buttonPadding, right: -buttonPadding))
        rightStackView.leadingAnchor.constraint(equalTo: textView.trailingAnchor, constant: buttonPadding).isActive = true
        rightStackViewWidthConstraint = rightStackView.widthAnchor.constraint(equalToConstant: 0)
        rightStackViewWidthConstraint.isActive = true
        rightStackView.heightAnchor.constraint(equalToConstant: InputTextView.buttonItemHeight).isActive = true
        self.setupTwoRightButtons()
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 10000, height: 0.5)
        topBorder.backgroundColor = UIColor.lightGray.cgColor
        
        self.layer.addSublayer(topBorder)
        self.clipsToBounds = true
    }
    
    
    fileprivate func setupLeftBarItems() {
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        leftStackView.addArrangedSubview(addButton)
        self.setLeftStackViewWidth(InputTextView.buttonItemHeight)
    }
    
    fileprivate func setupTwoRightButtons() {
        firstRightButton.setImage(UIImage(named: "camera"), for: .normal)
        firstRightButton.addTarget(self, action: #selector(cameraButtonTapped(_:)), for: .touchUpInside)
        rightStackView.addArrangedSubview(firstRightButton)
        secondRightButton.setImage(UIImage(named: "mic"), for: .normal)
        secondRightButton.addTarget(self, action: #selector(secondButtonTapped(_:)), for: .touchUpInside)
        secondRightButton.tag = 120 // 120 for mic, 121 for send
        rightStackView.addArrangedSubview(secondRightButton)
        self.setRightStackViewWidth(InputTextView.buttonItemHeight * 2)
    }
    
    fileprivate func showSendButton() {
        self.rightStackView.removeArrangedSubview(firstRightButton)
        firstRightButton.removeFromSuperview()
        secondRightButton.setImage(UIImage(named: "send"), for: .normal)
        secondRightButton.tag = 121
        self.setRightStackViewWidth(InputTextView.buttonItemHeight)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    fileprivate func showCameraAndMicButton() {
        firstRightButton.setImage(UIImage(named: "camera"), for: .normal)
        rightStackView.insertArrangedSubview(firstRightButton, at: 0)
        secondRightButton.setImage(UIImage(named: "mic"), for: .normal)
        secondRightButton.tag = 120
        self.setRightStackViewWidth(InputTextView.buttonItemHeight * 2)
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    func setLeftStackViewWidth(_ width: CGFloat) {
        leftStackViewWidthConstraint.constant = width
    }
    
    func setRightStackViewWidth(_ width: CGFloat) {
        rightStackViewWidthConstraint.constant = width
    }
    
    @objc func addButtonTapped(_ sender: UIButton) {
        delegate?.didPressAddMoreButton?(sender)
    }
    
    @objc func cameraButtonTapped(_ sender: UIButton) {
        delegate?.didPressCameraButton?(sender)
    }
    
    @objc func secondButtonTapped(_ sender: UIButton) {
        if textView.text.isEmpty {
            delegate?.didPressMicButton?(sender)
        }else {
            delegate?.didPressSendButton(textView.text, sender, textView)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension InputTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let startHeight = textView.frame.size.height
        var calcHeight = textView.sizeThatFits(textView.frame.size).height
        if startHeight != calcHeight {
            calcHeight = calcHeight < InputTextView.textViewHeight ? InputTextView.textViewHeight : calcHeight
            self.textViewHeightConstraint.constant = calcHeight
        }
        
        if textView.text.isEmpty {
            if secondRightButton.tag == 121 {
                self.showCameraAndMicButton()
            }
        }else {
            if secondRightButton.tag == 120 {
                self.showSendButton()
            }
        }
        
    }
    
}
