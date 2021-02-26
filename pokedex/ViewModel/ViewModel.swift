//
//  PokeListViewModel.swift
//  pokedex
//
//  Created by APPMAN M-021 on 23/2/2564 BE.
//

import Foundation
import UIKit

class ViewModel {
    
//    private var pokemontList = ApiManager().pokemonList
//    private var pokemon: Pokedex?
    
    func getNumberOfPokemon(pokemon: Pokedex) -> Int{
        return pokemon.cards.count ?? 0
    }

    func getPokemon(pokemon: Pokedex) -> Pokedex? {
        return pokemon
    }

//    func updatePokemon(pokemon: Pokedex, isSelected: Bool, index: Int) {
//        pokemon.cards[index].isSelected = isSelected
//    }

    func initNextScreen() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokeListViewController")
        vc.modalPresentationStyle = .popover
        return vc
    }
}
