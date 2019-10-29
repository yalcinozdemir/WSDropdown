//
//  ViewController.swift
//  WSDropdownExample
//
//  Created by Yalcin on 2019-10-29.
//  Copyright © 2019 Windscribe. All rights reserved.
//

import UIKit
import WSDropdown

class ViewController: UIViewController, WSDropdownButtonDelegate, WSDropdownDelegate {
    
    var infoLabel: UILabel!
    var dropdownButton: WSDropdownButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .dark
        }
        self.view.backgroundColor = UIColor.black
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOnView))
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
        
        infoLabel = UILabel()
        infoLabel.font = UIFont.boldSystemFont(ofSize: 20)
        infoLabel.text = "Favourite Fruit"
        self.view.addSubview(infoLabel)

        dropdownButton = WSDropdownButton()
        dropdownButton.delegate = self
        dropdownButton.setTitle("select here")
        self.view.addSubview(dropdownButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints([
            NSLayoutConstraint(item: infoLabel!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -100),
            NSLayoutConstraint(item: infoLabel!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: infoLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 20)
        ])
        self.view.addConstraints([
           NSLayoutConstraint(item: dropdownButton!, attribute: .top, relatedBy: .equal, toItem: self.infoLabel, attribute: .bottom, multiplier: 1.0, constant: 20),
           NSLayoutConstraint(item: dropdownButton!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0),
           NSLayoutConstraint(item: dropdownButton!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 150),
           NSLayoutConstraint(item: dropdownButton!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 20)
       ])
    }
    
    @objc func tappedOnView() {
        dropdownButton.remove()
    }
    
    //MARK: DropdownButtonDelegate
    
    func dropdownButtonTapped(_ sender: WSDropdownButton) {
        let dropdown = WSDropdown(attachedView: sender)
        dropdown.width = 150
        dropdown.dropdownDelegate = self
        dropdown.options = ["Apple 🍎", "Cherry 🍒", "Banana 🍌", "Strawberry 🍓", "Tomato? 🍅", "Watermelon 🍉", "Kiwi 🥝", "Peach 🍑", "Grapes 🍇"]
        dropdownButton.dropdown = dropdown
        self.view.addSubview(dropdown)
    }
    
    //MARK: DropdownDelegate
    
    func optionSelected(dropdown: WSDropdown, option: String, index: Int) {
        // take action
    }

}


