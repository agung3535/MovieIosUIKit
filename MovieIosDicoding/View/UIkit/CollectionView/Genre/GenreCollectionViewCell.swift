//
//  GenreCollectionViewCell.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import UIKit
import SwiftUI


class GenreCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "GenreCollectionViewCell"
    
    lazy var host: UIHostingController = {
        return UIHostingController(rootView: GenreMovie())
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        host.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(host.view)
        
        
        NSLayoutConstraint.activate([
                    host.view.topAnchor.constraint(equalTo: contentView.topAnchor),
                    host.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    host.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    host.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])
    }
    
    
}
