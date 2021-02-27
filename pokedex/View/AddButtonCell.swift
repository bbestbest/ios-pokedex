
import Foundation
import UIKit

protocol AddPokemonButton {
    func onClickAddPokemon (index: Int, idPoke: String)
}
class AddButtonCell: UITableViewCell {
    
    var cellDelegate: AddPokemonButton?
    var index: IndexPath?
    var idPoke: String?
    
    @IBAction func addPokemonButton(_ sender: Any) {
        cellDelegate?.onClickAddPokemon(index: index!.row, idPoke: idPoke!)
    }
    
}
