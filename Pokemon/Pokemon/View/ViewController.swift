//
//  ViewController.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import UIKit
import SnapKit
import SDWebImage


class ViewController: UIViewController {
    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lista Pokemon."
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var viewModel = PokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.loadData()
        viewModel.reloadtableView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
private extension ViewController {
    func setupView() {
        view.addSubview(tituloLabel)
        view.addSubview(tableView)
        setupConstraint()
    }
    
    func setupConstraint() {
        
        tituloLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tituloLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PokemonTableViewCell else {
            return UITableViewCell() }
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.title.text = cellViewModel.name
        return cell
    }
}
extension ViewController: UITableViewDelegate {
    
}


