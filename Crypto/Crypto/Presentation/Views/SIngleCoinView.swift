//
//  SIngleCoinView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 04/06/2023.
//

import SwiftUI
import SwiftUICharts

struct SIngleCoinView: View {
    @ObservedObject var singleViewData = SingleCoinViewModel()
    @State var coinData : Cryptocurrency
    @State var prices : [Double]
    @State var last24HsRate : Int
    
    var body: some View {
        VStack(alignment: .center){
            HStack(alignment: .center){
                Text("Price")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("MainColor"))
                Text("USD $" + String(format: "%.1f",coinData.quote.USD.price))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("MainColor"))
                    .padding(.leading)
            }
            .padding(.bottom, -200)
            LineChartView(data: prices, title: "Last 24hs", legend: coinData.name, style: ChartStyle(backgroundColor: Color("MainView"), accentColor: Color.blue, secondGradientColor: .red, textColor: Color("MainView"), legendTextColor: Color.green, dropShadowColor:.yellow), form: ChartForm.extraLarge, rateValue: last24HsRate, dropShadow: false)
                .padding(.bottom,300.0)
        }
        .onAppear{
            singleViewData.chargeCoinData(cryptocurrency: coinData)
        }
        .onReceive(self.singleViewData.$prices){price in
            prices = price
        }
        .onReceive(self.singleViewData.$rate){rate in
            last24HsRate = rate
        }
    }
}

struct SIngleCoinView_Previews: PreviewProvider {
    static var previews: some View {
        SIngleCoinView(coinData: Cryptocurrency(id: 0, name: "", symbol: "", slug: "", quote: Quote(USD: QuoteDetail(price: 0, volume_24h: 0, volume_change_24h: 0, percent_change_1h: 0, percent_change_24h: 0, percent_change_7d: 0, market_cap: 0, market_cap_dominance: 0, fully_diluted_market_cap: 0, last_updated: ""))), prices: [1.0], last24HsRate: 0)
    }
}
