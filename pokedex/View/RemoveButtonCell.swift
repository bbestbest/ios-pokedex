

import Foundation
import UIKit

protocol RemovePokemonButton {
    func onClickRemovePokemon (index: Int)
}

class RemoveButtonCell: UITableViewCell {

    var cellDelegate: RemovePokemonButton?
    var index: IndexPath?

//    @IBAction func removePokemonButton(_ sender: Any) {
//    }
    @IBAction func removePokemonButton(_ sender: Any) {
        cellDelegate?.onClickRemovePokemon(index: index!.row)
    }
}
