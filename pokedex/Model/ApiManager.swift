

import Foundation
import Moya

protocol ApplyMoya {
    func callingAPIByMoya()
}

class ApiManager {
    public var pokemonList: Pokedex?
    public var checkStatus: Int = 404
    
    func callingAPIByMoya() {
        let provider = MoyaProvider<MyService>()
        provider.request(.getUsers) { (result) in
            switch result {
            case let .success(moyaResponse):
                print("Connection Pass")

                let statusCode = moyaResponse.statusCode
                self.checkStatus = statusCode
                print(statusCode)
                let data = moyaResponse.data
                return self.mappingPokemons(data: data)
            case .failure(_):
                print("Connection failed")
                break
            }
        }
    }

    private func mappingJson(response: Response) {
        do {
            let successResponse = try
                response.filterSuccessfulStatusCodes()
            let json = try successResponse.mapJSON()
            print ("json = \(json)")
        } catch let error {
            print(error)
        }
    }

    private func mappingPokemons(data: Data) {
        do {
            let pokemon = try JSONDecoder().decode(Pokedex.self, from: data)
            pokemonList = pokemon
        } catch let error {
            print(error)
        }
    }
    
}
