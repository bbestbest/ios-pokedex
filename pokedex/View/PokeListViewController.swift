//
//  PokeListViewController.swift
//  pokedex
//
//  Created by APPMAN M-021 on 2/2/2564 BE.
//

import UIKit
import SDWebImage

class PokeListViewController: UIViewController, AddPokemonButton {
    private var apiManager = ApiManager()
    var pokeListVM: PokeListViewModel?
    var getCellIndex: IndexPath?
    var pokemonList: Pokedex?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func onClickAddPokemon (index: Int) {
        pokemonList = pokeListVM!.addPokemonToPokedex(currentPokemonList: pokemonList!, index: index)

        pokeListVM!.verifyBack()

        tableView.reloadData()
    }
}

extension PokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeListVM!.getNumberOfPokemon(pokemon: pokemonList!)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddButtonCell
        let index = indexPath.row

        if let pokemon = (pokemonList?.cards[index]) {
            if(pokemon.isSelected == false) {
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
