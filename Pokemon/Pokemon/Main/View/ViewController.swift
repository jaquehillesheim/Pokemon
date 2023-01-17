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


class ViewController: UIViewController {

    
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
        let lottieAnimationView = LottieAnimationView(name: "Pokemon")
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        lottieAnimationView.loopMode = .repeat(2.0)
        lottieAnimationView.backgroundColor = .redMain
      return lottieAnimationView
    }()
     
    private lazy var alert = UIAlertController()
    private lazy var viewModel = PokemonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLottie()
        viewModel.delegate = self

        navigationController?.navigationBar.tintColor = .black
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
             UIView.animate(withDuration: 0, animations: {
             self.animationView.alpha = 0
           }, completion: { _ in
             self.viewModel.loadData()
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
        navigationItem.backButtonTitle = "Voltar"
        view.addSubview(tituloLabel)
        view.addSubview(tableView)
        setupConstraint()
    }
    
    func setupConstraint() {
        
        tituloLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tituloLabel.snp.bottom).offset(30)
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
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.title.text = cellViewModel.name
        
        cell.pokemonImage.sd_setImage(with: cellViewModel.urlImage)
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

