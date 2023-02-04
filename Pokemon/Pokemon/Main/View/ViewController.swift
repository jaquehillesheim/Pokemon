//
//  ViewController.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import UIKit
import SnapKit
import SDWebImage
import Lottie


class ViewController: UIViewController, UISearchBarDelegate {

    
    private lazy var tituloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pokédex"
        label.textColor = .white
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private let animationView: LottieAnimationView = {
        let lottieAnimationView = LottieAnimationView(name: "pokemon")
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        lottieAnimationView.loopMode = .repeat(2.0)
        lottieAnimationView.backgroundColor = .redMain
        
      return lottieAnimationView
    }()
    
    // Mark: SearchBar = Barra de pesquisa
    private lazy var searchbar: UISearchBar = {
        let search = UISearchBar()
        search.barTintColor = .redMain
        search.placeholder = "Procure seu Pokémon"
        let textField = search.value(forKey: "searchField") as? UITextField
        textField?.textColor = .black
        textField?.backgroundColor = .white
        
        return search
    }()
     
    private lazy var alert = UIAlertController()
    private lazy var viewModel = PokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        setupLottie()
        bind()
        viewModel.delegate = self
        searchbar.delegate = self

        navigationController?.navigationBar.tintColor = .black
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterResults(searchText)
        tableView.reloadData()
    }
    
    func bind() {
        viewModel.viewData.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
           
        }
    }
}
private extension ViewController {
    
    
    
    func setupLottie() {
        // 1 - adicionar animação lottie para iniciar Pokemon
        
         view.addSubview(animationView)

         animationView.frame = view.bounds
         animationView.center = view.center
         animationView.alpha = 1
        
        animationView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }

         animationView.play { _ in
             UIView.animate(withDuration: 2, animations: {
             self.animationView.alpha = 0
           }, completion: { _ in
             self.animationView.isHidden = true
             self.animationView.removeFromSuperview()
            
           })
         }
    }
    
    
    func setupView() {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .clear
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        view.backgroundColor = .redMain
        navigationItem.backButtonTitle = "Pokedex"
        view.addSubview(tituloLabel)
        view.addSubview(searchbar)
        view.addSubview(tableView)
        
        setupConstraint()
    }
    
    func setupConstraint() {
        
        tituloLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        searchbar.snp.makeConstraints { make in
            make.top.equalTo(tituloLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchbar.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(6)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let model = viewModel.getCellViewModel(at: indexPath)
        cell.title.text = model.name
        cell.pokemonImage.sd_setImage(with: model.imageUrl)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = .white
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        let url = viewModel.didSelectPokemon(at: indexPath)
        let viewController = PokemonDetailsViewController(url: url)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
extension ViewController: PokemonViewModelDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Atenção", message: "Não foi possivel carregar o Pokemon", preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "Tente Novamente",
            style: .default,
            handler: {_ in
                self.viewModel.loadData()
                self.reloadTableView()
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
    
}

