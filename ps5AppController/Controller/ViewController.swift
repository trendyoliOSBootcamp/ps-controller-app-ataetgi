//
//  ViewController.swift
//  ps5AppController
//
//  Created by Ata Etgi on 1.05.2021.
//

import SwiftUI
import UIKit

class ViewController: UIViewController {
    
    let products: [Product] = [
        .init(name: "Dual Sense", description: "Official PS5 Controller", image: "blackPSController"),
        .init(name: "Dual Sense White", description: "Official PS5 Controller", image: "whitePSController"),
        .init(name: "Dual Sense", description: "Official PS5 Controller", image: "blackPSController"),
    ]

    let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "background"))
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let productsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Products"
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFontMetrics.default.scaledFont(for: .systemFont(ofSize: 41, weight: .thin))
        return lbl
    }()
    
    let basketButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        button.setImage(#imageLiteral(resourceName: "basket").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    
    let controllerButton: HomeControllerButton = {
        let button = HomeControllerButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "controllerIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleCenterButton), for: .touchUpInside)
        return button
    }()
    
    let switchButton: HomeControllerButton = {
        let button = HomeControllerButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "switchIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleCenterButton), for: .touchUpInside)
        return button
    }()
    
    let mouseButton: HomeControllerButton = {
        let button = HomeControllerButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "mouseIcon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleCenterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var centerButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [controllerButton, switchButton, mouseButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    var collectionView: UICollectionView!
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.71), heightDimension: .fractionalHeight(0.9)), subitems: [item])
//        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = false
        
        controllerButton.isSelected = true
        
        view.addSubview(backgroundImageView)
        view.addSubview(basketButton)
        view.addSubview(productsLabel)
        view.addSubview(centerButtonStack)
        view.addSubview(collectionView)
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellId)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            basketButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            basketButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            productsLabel.topAnchor.constraint(equalTo: basketButton.bottomAnchor, constant: 0),
            productsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            centerButtonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerButtonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: centerButtonStack.bottomAnchor, constant: 50)
            
        ])
    
        collectionView.reloadData()
        
        
    }

    @objc private func handleCenterButton(sender: UIButton) {
        [controllerButton, switchButton, mouseButton].forEach { btn in
            btn.isSelected = false
        }
        
        sender.isSelected = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCell
        cell.configureCell(product: products[indexPath.item])
        return cell
        
    }
    
    
    
    
    
}

struct HomePreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewDevice("iPhone 11")
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> some UIViewController {
            ViewController()
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}


