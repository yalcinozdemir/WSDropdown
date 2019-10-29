//
//  WSDropdown.swift
//  WSDropdown
//
//  Created by Yalcin on 2019-10-29.
//  Copyright © 2019 Windscribe. All rights reserved.
//

import UIKit

public protocol WSDropdownDelegate {
    func optionSelected(dropdown: WSDropdown, option: String, index: Int)
}

public final class WSDropdown: UITableView {

    public var dropdownDelegate: WSDropdownDelegate?
    public var options = [String]() {
        didSet {
            self.prepareTableView()
        }
    }
    var height: CGFloat {
        get {
            return CGFloat(self.options.count * 45)
        }
    }
    public var width: CGFloat = 124
    public var maxHeight: CGFloat = 135
    public var relatedIndex: Int = 0
    let reuseIdentifier = "dropdownCell"
    public var attachedView: WSDropdownButton?
    var point: CGPoint {
        get {
            guard let maxX = attachedView?.frame.maxX, let minY = attachedView?.frame.minY else { return CGPoint.zero }
            return CGPoint(x: maxX, y: minY)
        } set {
            return
        }
    }
    
    public init(attachedView: WSDropdownButton) {
        super.init(frame: CGRect(x: attachedView.frame.maxX, y: attachedView.frame.minY, width: 0, height: 0), style: .plain)
        self.attachedView = attachedView
        self.backgroundColor = UIColor.white
        self.indicatorStyle = .black
        self.layer.cornerRadius = 3.0
        self.register(DropDownTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.rowHeight = 45
        self.separatorStyle = .none
        self.allowsSelection = true
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func prepareTableView() {
        UIView.animate(withDuration: 0.25, animations: {
            if self.height <= 150 {
                self.frame = CGRect(x: self.point.x-self.width, y: self.point.y, width: self.width, height: self.height)
            } else {
                self.frame = CGRect(x: self.point.x-self.width, y: self.point.y, width: self.width, height: self.maxHeight)
            }
        }, completion: { (result) in
            self.flashScrollIndicators()
        })
    }
    
    func removeWithAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            for cell in self.visibleCells {
                cell.layer.opacity = 0.0
            }
            self.frame = CGRect(x: self.point.x, y: self.point.y, width: 0, height: 0)
        }) { (result) in
            self.removeFromSuperview()
        }
    }

}

extension WSDropdown: UITableViewDelegate, UITableViewDataSource, DropDownTableViewCellDelegate {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? DropDownTableViewCell ?? DropDownTableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.button.setTitle(self.options[indexPath.row], for: .normal)
        cell.button.setTitleColor(UIColor.black, for: .normal)
        cell.row = indexPath.row
        cell.delegate = self
       return cell
    }
    
    func buttonTapped(row: Int) {
        let value = options[row]
        self.dropdownDelegate?.optionSelected(dropdown: self, option: value, index: row)
        self.removeWithAnimation()
    }
    
}

protocol DropDownTableViewCellDelegate {
    func buttonTapped(row: Int)
}

class DropDownTableViewCell: UITableViewCell {
    
    var button = UIButton()
    var delegate: DropDownTableViewCellDelegate?
    var row: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
                
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints([
         NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 20),
         NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1.0, constant: -20),
         NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
         NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
         ])
    }
    
    @objc func buttonTapped() {
        self.delegate?.buttonTapped(row: self.row)
    }
    
}
