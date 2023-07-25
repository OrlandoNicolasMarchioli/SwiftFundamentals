//
//  TestViewView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 17/07/2023.
//

import SwiftUI

struct CoinListView: View {
    @ObservedObject var coinListViewModel = CoinListViewModel()
    
    var body: some View {
        NavigationView {
            List(coinListViewModel.cryptocurrencies, id: \.id) { cryptocurrency in
                NavigationLink(destination: SIngleCoinView( coinData: cryptocurrency, prices: [], last24HsRate: 0)) {
                    HStack{
                        Image(cryptocurrency.symbol)
                            .resizable()
                            .frame(width: 64,height: 64)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .shadow(radius: 10)
                        VStack(alignment: .leading) {
                            Text(cryptocurrency.name)
                                .font(.headline)
                            Text(cryptocurrency.symbol)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("USD Price: \(cryptocurrency.quote.USD.price, specifier: "%.1f")")
                    }
                }
            }
            .navigationBarTitle("Cryptocurrencies")
        }
        .onAppear {
            coinListViewModel.fetchCryptocurrencyData()
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}
