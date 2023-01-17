//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import Foundation
import UIKit

protocol PokemonViewModelDelegate {
    func presentAlert()
    func reloadTableView()
}

class PokemonViewModel {
    
    var pokemons: PokemonsModel?
    var delegate: PokemonViewModelDelegate?
    
    private let service = PokemonService()
    
    private var cellViewModels: [PokemonCellViewModel] = [PokemonCellViewModel] () {
        didSet {
            self.delegate?.reloadTableView()
        }
    }
    
    func loadData() {
        service.fetchPokemon() { result in
            switch result {
            case .success(let pokemons):
                self.createCell(pokemons: pokemons)
            case .failure(_):
                self.delegate?.presentAlert()
                
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PokemonCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(pokemons: PokemonsModel) {
        self.pokemons = pokemons
        var number = 0
        var viewModels = [PokemonCellViewModel]()
        for pokemon in pokemons.results {

            number += 1
            guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number).png") else { return }
            viewModels.append(PokemonCellViewModel(name: "#\(number) \(pokemon.name.capitalized)", urlImage: url))
        }
        cellViewModels = viewModels
        delegate?.reloadTableView()
    }
    
    func didSelectPokemon(at indexPath: IndexPath) -> String {
        return pokemons?.results[indexPath.row].url ?? ""
    }
}

struct PokemonCellViewModel {
    let name: String?
    let urlImage: URL?
}
