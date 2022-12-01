//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import Foundation

struct PokemonModel: Decodable {
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
}
