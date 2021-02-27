

import UIKit


import UIKit

class ViewController: UIViewController, PassDatafromPokemonList, RemovePokemonButton {
    private var apiManager = ApiManager()
    var pokedexVM = ViewModel()
    var pokemonVM = PokeListViewModel()
    var isNotSelectPokemon: Pokedex = Pokedex.init(cards: [])
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
        isNotSelectPokemon =  pokedexVM.storePokemon(pokemonList: pokemonVM.isNotSelectPokemon)
        pokemonVM.isNotSelectPokemon = isNotSelectPokemon
        pokedexVM.isNotSelect.cards = []
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
                
                let pokemonStar = cell.viewWithTag(21) as! UIImageView
                let pokemonStar2 = cell.viewWithTag(22) as! UIImageView
                let pokemonStar3 = cell.viewWithTag(23) as! UIImageView
                let pokemonStar4 = cell.viewWithTag(24) as! UIImageView
                let pokemonStar5 = cell.viewWithTag(25) as! UIImageView
                
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
                
                switch pokemon.rarity {
                case 1:
                    pokemonStar.image = UIImage(named: "starIcon")

                case 2:
                    pokemonStar.image = UIImage(named: "starIcon")
                    pokemonStar2.image = UIImage(named: "starIcon")

                case 3:
                    pokemonStar.image = UIImage(named: "starIcon")
                    pokemonStar2.image = UIImage(named: "starIcon")
                    pokemonStar3.image = UIImage(named: "starIcon")
                case 4:
                    pokemonStar.image = UIImage(named: "starIcon")
                    pokemonStar2.image = UIImage(named: "starIcon")
                    pokemonStar3.image = UIImage(named: "starIcon")
                    pokemonStar4.image = UIImage(named: "starIcon")
                case 5:
                    pokemonStar.image = UIImage(named: "starIcon")
                    pokemonStar2.image = UIImage(named: "starIcon")
                    pokemonStar3.image = UIImage(named: "starIcon")
                    pokemonStar4.image = UIImage(named: "starIcon")
                    pokemonStar5.image = UIImage(named: "starIcon")
                default:
                    print("not found ")
                }
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
