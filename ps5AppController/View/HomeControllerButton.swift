//
//  HomeControllerButton.swift
//  ps5AppController
//
//  Created by Ata Etgi on 1.05.2021.
//

import UIKit

class HomeControllerButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setBackgroundImage(#imageLiteral(resourceName: "unSelectedTabBackground").withRenderingMode(.alwaysOriginal), for: .normal)
        setBackgroundImage(#imageLiteral(resourceName: "selectedTabBackground").withRenderingMode(.alwaysOriginal), for: .selected)
        
        widthAnchor.constraint(equalToConstant: 67).isActive = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        isSelected = false
    }
    

    override var isSelected: Bool {
        didSet {
            tintColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) :  #colorLiteral(red: 0.5044669509, green: 0.5438601971, blue: 0.6186739802, alpha: 1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
