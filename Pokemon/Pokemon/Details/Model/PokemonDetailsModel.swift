//
//  PokemonDetailsModel.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 02/12/22.
//

struct PokemonDetailsModel: Decodable {
    let id: Int?
    let name: String?
    let sprites: Sprites
    let height: Double?
    let weight: Double?
    let species: Species
    let stats: [Stats]
    let moves: [Moves]
}


struct Sprites: Decodable {
    let other: SpritesOther

}
struct SpritesOther: Decodable {
    let home: SpritesHome
}

struct SpritesHome: Decodable {
    let frontDefault: String
    let frontShiny: String
}

struct Species: Decodable {
    let name: String
    let url: String
}
struct SpeciesDetails: Decodable {
    let color: Color
}
struct Color: Decodable {
    let name: String
    let url: String
}

struct Stats: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: StatDetails
}

struct StatDetails: Decodable {
    let name: String
    let url: String
}

struct Moves: Decodable {
    let move: MoveDetails
}

struct MoveDetails: Decodable {
    let name: String
    let url: String

}
