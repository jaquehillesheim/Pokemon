//
//  PokemonDetailsViewController.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 01/12/22.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class PokemonDetailsViewController: UIViewController {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private var carouselView = CarouselView()
    
    private lazy var aboutView = AboutStatsView()

    private lazy var statsView = StatsView()
 
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [aboutView, statsView].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fill
        stack.axis = .vertical
        
        return stack
    }()
    
    private lazy var alert = UIAlertController()
    
    private let viewModel = PokemonDetailsViewModel()
    
    private let url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()
        viewModel.delegate = self
        
        viewModel.loadData(url: url)
    }
}

extension PokemonDetailsViewController {
    func setupview() {
        view.addSubview(nameLabel)
        view.addSubview(idLabel)
        view.addSubview(carouselView)
        view.addSubview(stackView)
        
        setupContraint()
    }
    
    func setupContraint() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.equalToSuperview().inset(20)
        }
        
        carouselView.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.size.equalTo(200)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(carouselView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setDetails() {
        carouselView.configureView(with: viewModel.createImages())
        nameLabel.text = viewModel.nameLabel
        idLabel.text = viewModel.idLabel
        
        let aboutModel = AboutModel(
            imageWeight: "balance",
            valueWeight: viewModel.weightLabel,
            imageHeight: "scale",
            valueHeight: viewModel.heightLabel,
            valueMoves: viewModel.moveLabel)
        aboutView.setupDetails(aboutModel: aboutModel)
  
        let statsModel = StatsModel(
            hpString: viewModel.hpStatsLabel,
            hpValue: viewModel.hpStatsValue,
            atkString: viewModel.atkStatsLabel,
            atkValue: viewModel.atkStatsValue,
            defString: viewModel.defStatsLabel,
            defValue: viewModel.defStatsValue,
            sAtkString: viewModel.sAtkStatsLabel,
            sAtkValue: viewModel.sAtkStatsValue,
            sDefString: viewModel.sDefStatsLabel,
            sDefValue: viewModel.sDefStatsValue,
            spdString: viewModel.spdStatsLabel,
            spdValue: viewModel.spdStatsValue,
            progressColor: viewModel.pokemonColor
        )
        statsView.setupDetails(statsModel: statsModel)
        view.backgroundColor = viewModel.pokemonColor
    }
}

extension PokemonDetailsViewController: PokemonDetailsViewModelDelegate {
    func presentAlert() {
        let alert = UIAlertController(title: "Atenção", message: "Não foi possivel carregar os detalhes do Pokemon", preferredStyle: .alert)
        let actionDeafult = UIAlertAction(
            title: "Tente Novamente",
            style: .default,
            handler: {_ in
                self.viewModel.loadData(url: self.url)
                self.loadDetails()
        })
        alert.addAction(actionDeafult)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func loadDetails() {
        DispatchQueue.main.async {
            self.setDetails()
        }
    }
}
