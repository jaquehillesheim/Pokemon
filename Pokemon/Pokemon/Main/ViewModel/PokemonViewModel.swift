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
    var delegate: PokemonViewModelDelegate?
    
    private let service = PokemonService()
    var viewData: Bindable<[PokemonViewData]> = Bindable([])
    private var pokemonsViewModel: [PokemonViewData] = [PokemonViewData]()
    private var searchPokemonsViewModel: [PokemonViewData] = [PokemonViewData]()
    
    init() {
        loadData()
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
        return viewData.value.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PokemonViewData {
        return viewData.value[indexPath.row]
    }
    
    func createCell(pokemons: PokemonsModel) {
        var number = 0
        for pokemon in pokemons.results {
            number += 1
            let model = PokemonModel(name: pokemon.name, url: pokemon.url, number: number)
            viewData.value.append(PokemonViewData(model: model))
        }
        pokemonsViewModel = viewData.value
        searchPokemonsViewModel = viewData.value
    }
    
    func didSelectPokemon(at indexPath: IndexPath) -> String {
        return viewData.value[indexPath.row].url 
    }
    func filterResults(_ searchText: String) {
        var listArray = searchPokemonsViewModel
        if searchText != "" {
            listArray = listArray.filter({ pokemon -> Bool in
                if pokemon.name.lowercased().contains(searchText.lowercased()) {
                    return true
                } else {
                    return false
                }
            })
        }
        viewData.value = listArray
    }
}
