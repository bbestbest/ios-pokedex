//
//  PokeListViewModel.swift
//  pokedex
//
//  Created by APPMAN M-021 on 23/2/2564 BE.
//

import Foundation

class PokeListViewModel {
    
    var pokemon: Pokedex?
    
    func getAllPokemon(pokemon: Pokedex) -> Pokedex? {
        return pokemon
    }

    func getNumberOfPokemon(pokemon: Pokedex) -> Int{
        return pokemon.cards.count ?? 0
    }

    func getPokemon(pokemon: Pokedex, at index: Int) -> Cards? {
        guard index >= 0, index < pokemon.cards.count ?? 0 else {return nil}
        return pokemon.cards[index]
    }

    func updatePokemon(isSelected: Bool, index: Int) {
        pokemon?.cards[index].isSelected = isSelected
    }

//    func verifyBack(name: String, age: String, at index: Int, with currentController: PokeListViewController) {
//        delegate?.backFromUsers(name: name, age: age, index: index)
//        currentController.dismiss(animated: true, completion: nil)
//    }
}
