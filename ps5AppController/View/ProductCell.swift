//
//  ProductCell.swift
//  ps5AppController
//
//  Created by Ata Etgi on 1.05.2021.
//

import UIKit

class ProductCell: UICollectionViewCell {
 
    let backgroundImage: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "controllerCellBackground"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let productImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .title3)
        lbl.minimumScaleFactor = 0.5
        lbl.textColor = .white
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.textColor = .white
        lbl.text = "HEYasdasd asd as das"
        lbl.minimumScaleFactor = 0.5
        lbl.numberOfLines = 1
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    func configureCell(product: Product) {
        
        productImage.image = UIImage(named: product.image)
        nameLabel.text = product.name
        descLabel.text = product.description
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backgroundImage)

        let productStack = UIStackView(arrangedSubviews: [productImage, nameLabel, descLabel])
        productStack.translatesAutoresizingMaskIntoConstraints = false
        productStack.axis = .vertical
        productStack.alignment = .leading
        productStack.distribution = .fill
        productStack.spacing = 2
        productStack.setCustomSpacing(30, after: productImage)
        
        backgroundImage.addSubview(productStack)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            productStack.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            productStack.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor,constant: -20),
     ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
