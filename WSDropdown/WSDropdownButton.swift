//
//  WSDropdownButton.swift
//  WSDropdown
//
//  Created by Yalcin on 2019-10-29.
//  Copyright © 2019 Windscribe. All rights reserved.
//

import UIKit

public protocol WSDropdownButtonDelegate {
    func dropdownButtonTapped(_ sender: WSDropdownButton)
}

public final class WSDropdownButton: UIView, WSDropdownDelegate {
    
    public var button: UIButton!
    public var icon: UIButton!
    public var dropdown: WSDropdown? {
        didSet {
            dropdown?.dropdownDelegate = self
        }
    }
    public var delegate: WSDropdownButtonDelegate!
    let bundle = Bundle(for: WSDropdownButton.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapRecognizer.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapRecognizer)
        
        button = UIButton()
        button.isUserInteractionEnabled = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textColor = UIColor.white
        button.layer.opacity = 0.80
        self.addSubview(button)
        
        icon = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        icon.isUserInteractionEnabled = false
        icon.setImage(UIImage(named: "dropdown-icon", in: bundle, compatibleWith: .none), for: .normal)
        self.addSubview(icon)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
           NSLayoutConstraint(item: button!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0),
           NSLayoutConstraint(item: button!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0),
           NSLayoutConstraint(item: button!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 20)
        ])
        self.addConstraints([
           NSLayoutConstraint(item: icon!, attribute: .centerY, relatedBy: .equal, toItem: self.button, attribute: .centerY, multiplier: 1.0, constant: 0),
           NSLayoutConstraint(item: icon!, attribute: .left, relatedBy: .equal, toItem: button, attribute: .right, multiplier: 1.0, constant: 6),
           NSLayoutConstraint(item: icon!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 16),
           NSLayoutConstraint(item: icon!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTitle(_ text: String?) {
        button.setTitle(text, for: .normal)
    }
    
    @objc func viewTapped() {
        self.delegate?.dropdownButtonTapped(self)
    }
    
    public func remove() {
        self.dropdown?.removeWithAnimation()
    }
    
    //MARK: DropdownDelegate
    
    public func optionSelected(dropdown: WSDropdown, option: String, index: Int) {
        self.setTitle(option)
    }
    
}
