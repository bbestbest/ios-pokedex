//
//  ViewController.swift
//  pokedex
//
//  Created by APPMAN M-021 on 2/2/2564 BE.
//

import UIKit


import UIKit

class ViewController: UIViewController, PassDatafromPokemonList, RemovePokemonButton {
    private var apiManager = ApiManager()
    private var pokedexVM = ViewModel()
    private var pokemonVM = PokeListViewModel()
    private var isNotSelectPokemon: Pokedex = Pokedex.init(cards: [])
    var getCellIndex: IndexPath?
    var pokemonList: Pokedex?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        apiManager.callingAPIByMoya()

        getDelegate()
    }

    @IBAction func nextButton(_ sender: Any) {
        if(apiManager.checkStatus == 200) {
            guard let nextVC = self.pokedexVM.initNextScreen() as? PokeListViewController else {return}
            nextVC.pokeListVM = pokemonVM
            if(pokemonList?.cards.count == nil || pokemonList?.cards.count == 0) {
                nextVC.pokemonList = pokedexVM.getPokemon(pokemon: apiManager.pokemonList!)
            } else if ((pokemonList?.cards.count)! > 0) {
                nextVC.pokemonList = pokedexVM.getPokemon(pokemon: isNotSelectPokemon)
            }
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    func onClickRemovePokemon(index: Int) {
        pokemonList = pokedexVM.removePokemonToList(currentPokemonList: pokemonList!, index: index)
        pokemonVM.isSelectPokemon = pokemonList!
        isNotSelectPokemon =  pokedexVM.storePokemon(pokemonList: pokemonVM.isNotSelectPokemon, index: index)
        pokemonVM.isNotSelectPokemon = isNotSelectPokemon
        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func backFromPokemonList(isSelected: Pokedex) {
        isNotSelectPokemon = pokemonVM.isNotSelectPokemon
        pokemonList = pokedexVM.getPokemon(pokemon: isSelected)
        tableView.reloadData()
    }

    func getDelegate() {
        pokemonVM.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList?.cards.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RemoveButtonCell
        let index = indexPath.row

        if let pokemon = (pokemonList?.cards[index]) {
            if(pokemon.isSelected == true) {
                let pokemonImage = cell.viewWithTag(1) as! UIImageView
                let pokemonName = cell.viewWithTag(2) as! UILabel
                let pokemonHP = cell.viewWithTag(10) as! UIProgressView
                let pokemonATK = cell.viewWithTag(9) as! UIProgressView
                let pokemonWEAK = cell.viewWithTag(8) as! UIProgressView

                pokemonImage.sd_setImage(with: URL(string: pokemon.imageUrl), placeholderImage: UIImage(named: "pokemon.png"))

                pokemonName.text = pokemon.name
                pokemonHP.progress = Float(pokemon.hp) / 200
                var damage: Float = 0
                var weakness: Float = 0
                for i in 0..<pokemon.attacks.count {
                    damage += Float(pokemon.attacks[i].damage) ?? 0
                    weakness += Float(pokemon.weaknesses.count * 10)
                }
                pokemonATK.progress = (damage -  weakness/10) / 100
                pokemonWEAK.progress = weakness / 100
                cell.cellDelegate = self
                cell.index = indexPath
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
