
import UIKit
import SDWebImage

class PokeListViewController: UIViewController,  UISearchBarDelegate, AddPokemonButton {
    private var apiManager = ApiManager()
    var pokeListVM: PokeListViewModel?
    var pokemonList: Pokedex!
    var getCellIndex: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!

    
    @IBOutlet weak var searcgBarInput: UISearchBar!
    var pokemonData: Pokedex!
    var filterData: Pokedex!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pokemonData = pokeListVM?.getAllPokemon(pokemon: pokemonList)
        searcgBarInput.delegate = self
        
        filterData = pokemonList
        
    }


    func onClickAddPokemon (index: Int,idPoke: String) {
        
        var realIndex: Int!
        
        for ( index, item) in pokemonList.cards.enumerated() {
            if item.id == idPoke {
                realIndex = index
            }
        }
        
        pokemonList = pokeListVM!.addPokemonToPokedex(currentPokemonList: pokemonList!, index: realIndex)
        
        filterData.cards.remove(at: index)

        pokeListVM!.verifyBack()

        tableView.reloadData()
    }
}

extension PokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.cards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddButtonCell
        let index = indexPath.row
        let _ : Cards! = pokemonList.cards[index]
        if let pokemon = (filterData?.cards[index])  {
            if(pokemon.isSelected == false){
                
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
                
                cell.cellDelegate = self
                cell.index = indexPath
                cell.idPoke = pokemon.id
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func backFromUsers(name: String, age: String, index: Int) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData.cards = []
        
        if searchText == ""  {
            filterData = pokemonList
        }
        else {
            for cards in pokemonList.cards as [Cards] {
                if cards.name.lowercased().contains(searchText.lowercased()){
                    filterData.cards.append(cards)
                }
            }
        }
        self.tableView.reloadData()
    }
}
