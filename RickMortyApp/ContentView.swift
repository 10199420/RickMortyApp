//
//  ContentView.swift
//  RickMortyApp
//
//  Created by Brayyan Christopher Trujillo Valle on 20/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
        
            Text("Hola Brayyan")
            VStack{
                AsyncImage(url: viewModel.characterBasicInfo.image)
                Text("Name:\(viewModel.characterBasicInfo.name)")
                Text("First Episode:\(viewModel.characterBasicInfo.firstEpisodeTitle)")
                Text("Dimension:\(viewModel.characterBasicInfo.dimension)")
            }
            .padding(.top, 32)
        }
        .onAppear{
            Task{
                await viewModel.executeRequest()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
