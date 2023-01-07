//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import Foundation
import UIKit
import SnapKit


class PokemonTableViewCell: UITableViewCell {
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var pokemonImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        backgroundColor = .clear
        title.textColor = .black
    }
    
    func setupLabel() {
        addSubview(title)
        addSubview(pokemonImage)
        
        title.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
        }
        
        pokemonImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
    }

}
