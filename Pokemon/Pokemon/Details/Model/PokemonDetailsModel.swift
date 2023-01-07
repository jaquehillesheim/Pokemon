struct PokemonDetailsModel: Decodable {
    let id: Int?
    let name: String?
    let sprites: Sprites
    let height: Double?
    let weight: Double?
    let species: ModelDefault
    let stats: [Stats]
    let moves: [Moves]
}

struct Sprites: Decodable {
    let frontDefault: String
    let other: SpritesOther
}

struct SpritesOther: Decodable {
    let home: SpritesHome
}

struct SpritesHome: Decodable {
    let frontDefault: String
    let frontShiny: String
}

struct SpeciesDetails: Decodable {
    let color: ModelDefault
}

struct Stats: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: ModelDefault
}

struct Moves: Decodable {
    let move: ModelDefault
}
