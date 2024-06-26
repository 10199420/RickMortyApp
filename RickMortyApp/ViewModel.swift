//
//  ViewModel.swift
//  RickMortyApp
//
//  Created by Brayyan Christopher Trujillo Valle on 25/06/24.
//

import Foundation


final class ViewModel: ObservableObject {
    @Published var characterBasicInfo: CharacterBasicInfo = .empty
    
    func executeRequest() async {
        let characterURL = URL(string: "https://rickandmortyapi.com/api/character/1")!
        
        let (data, _) = try! await URLSession.shared.data(from: characterURL)
        let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data)
        print("Character Model \(characterModel)")
        
        let firstEpisodeURL = URL(string: characterModel.episode.first!)!
        let (dataFirstEpisode, _) = try! await URLSession.shared.data (from: firstEpisodeURL)
        let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: dataFirstEpisode)
        print("Episode Model \(episodeModel)")
        
        let characterLocationURL = URL(string: characterModel.locationURL)!
        let (dataLocation, _) = try! await URLSession.shared.data (from: characterLocationURL)
        let locationModel = try! JSONDecoder().decode(LocationModel.self, from: dataLocation)
        print("Location Model \(locationModel)")
        
        DispatchQueue.main.async {
            self.characterBasicInfo = .init(name: characterModel.name,
                                            image: URL(string: characterModel.image)!,
                                            firstEpisodeTitle: episodeModel.name,
                                            dimension: locationModel.dimension)
        }
        
       /* URLSession.shared.dataTask(with: characterURL) { data, response, error in
            let characterModel = try! JSONDecoder().decode(CharacterModel.self, from: data!)
            print("Character Model \(characterModel)")
            
            let firstEpisodeURL = URL(string: characterModel.episode.first!)!
            
            URLSession.shared.dataTask(with: firstEpisodeURL){ data, response, error in
                let episodeModel = try! JSONDecoder().decode(EpisodeModel.self, from: data!)
                print("Episode Model \(episodeModel)")
                
                let characterLocationURL = URL(string: characterModel.locationURL)!
                
                URLSession.shared.dataTask(with: characterLocationURL){ data, response, error in
                    let locationModel = try! JSONDecoder().decode(LocationModel.self, from: data!)
                    print("Location Model \(locationModel)")
                    DispatchQueue.main.async {
                        self.characterBasicInfo = .init(name: characterModel.name,
                                                        image: URL(string: characterModel.image)!,
                                                        firstEpisodeTitle: episodeModel.name,
                                                        dimension: locationModel.dimension)
                    }
                }.resume()
            }.resume()
        }.resume()
        */
    }
}
