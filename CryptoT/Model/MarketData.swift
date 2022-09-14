//
//  MarketData.swift
//  CryptoT
//
//  Created by Pierre on 13/09/2022.
//

import Foundation

// JSON data:
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 12914,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 573,
     "total_market_cap": {
       "btc": 49897782.72234385,
       "eth": 648684535.6349322,
       "ltc": 17750386452.512356,
       "bch": 8590183085.180332,
       "bnb": 3785429171.1618967,
       "eos": 669784291020.3706,
       "xrp": 3116577306872.75,
       "xlm": 9754204394121.506,
       "link": 142689237073.2176,
       "dot": 145026074606.0865,
       "yfi": 111462690.52448158,
       "usd": 1112051261661.9949,
       "aed": 4084558723828.2026,
       "ars": 158213990629940.12,
       "aud": 1613917771947.5305,
       "bdt": 105694539627491.5,
       "bhd": 419236653339.00244,
       "bmd": 1112051261661.9949,
       "brl": 5664900332032.359,
       "cad": 1443164524821.8564,
       "chf": 1059315566731.4607,
       "clp": 999011250914055.1,
       "cny": 7707960909957.777,
       "czk": 26903856173388.68,
       "dkk": 8157563235047.708,
       "eur": 1096958501938.718,
       "gbp": 949602813358.4121,
       "hkd": 8727878724591.084,
       "huf": 435914086110147.25,
       "idr": 16516585902404564,
       "ils": 3729875534177.418,
       "inr": 88023136533801.62,
       "jpy": 158328298379126.78,
       "krw": 1529960357101233.5,
       "kwd": 342595192436.51904,
       "lkr": 402633860336489,
       "mmk": 2335714605761447,
       "mxn": 22026175817435.562,
       "myr": 5012126241436.785,
       "ngn": 466592382159973.06,
       "nok": 10965447076642.562,
       "nzd": 1812117556262.2883,
       "php": 63140049870798.47,
       "pkr": 257068559830790.72,
       "pln": 5159002635923.295,
       "rub": 66695273306126.836,
       "sar": 4179422256704.275,
       "sek": 11640001803249.066,
       "sgd": 1551050177971.9927,
       "thb": 40335209087639.71,
       "try": 20288185374173.105,
       "twd": 34377397789439.34,
       "uah": 41077532218131.89,
       "vef": 111349692830.21556,
       "vnd": 26184396593313930,
       "zar": 18953323521724.51,
       "xdr": 822800056196.1403,
       "xag": 56221119356.3742,
       "xau": 645567998.4200219,
       "bits": 49897782722343.84,
       "sats": 4989778272234385
     },
     "total_volume": {
       "btc": 4173656.6712897005,
       "eth": 54258654.232803196,
       "ltc": 1484715648.543723,
       "bch": 718518398.7145057,
       "bnb": 316628933.22992855,
       "eos": 56023524934.91521,
       "xrp": 260683400318.60516,
       "xlm": 815881949488.2804,
       "link": 11935117228.46947,
       "dot": 12130579973.037697,
       "yfi": 9323199.880364336,
       "usd": 93016561334.56538,
       "aed": 341649364699.0523,
       "ars": 13233671747669.152,
       "aud": 134994749431.73213,
       "bdt": 8840727911495.707,
       "bhd": 35066685523.763176,
       "bmd": 93016561334.56538,
       "brl": 473835665094.40875,
       "cad": 120712242471.93245,
       "chf": 88605529962.9577,
       "clp": 83561427874906.98,
       "cny": 644725691578.2725,
       "czk": 2250349668367.1436,
       "dkk": 682332287325.836,
       "eur": 91754140564.13264,
       "gbp": 79428702054.8122,
       "hkd": 730035830806.2697,
       "huf": 36461654894097.63,
       "idr": 1381515473785408.5,
       "ils": 311982197544.19934,
       "inr": 7362618757358.854,
       "jpy": 13243232920008.768,
       "krw": 127972204431539.7,
       "kwd": 28656077133.14623,
       "lkr": 33677959332008.91,
       "mmk": 195368818306224.34,
       "mxn": 1842360334024.9104,
       "myr": 419234943591.02026,
       "ngn": 39027714305687.89,
       "nok": 917195291016.6028,
       "nzd": 151572998141.83057,
       "php": 5281294598503.632,
       "pkr": 21502276277221.664,
       "pln": 431520291962.40393,
       "rub": 5578668173023.994,
       "sar": 349584142463.697,
       "sek": 973617834890.2914,
       "sgd": 129736244169.80513,
       "thb": 3373803510132.9,
       "try": 1696987633828.5164,
       "twd": 2875467561832.6484,
       "uah": 3435894483254.3164,
       "vef": 9313748286.430033,
       "vnd": 2190171097050433.2,
       "zar": 1585334274264.9573,
       "xdr": 68822395632.07693,
       "xag": 4702566668.639411,
       "xau": 53997974.18594195,
       "bits": 4173656671289.7007,
       "sats": 417365667128970.06
     },
     "market_cap_percentage": {
       "btc": 38.37731850041711,
       "eth": 18.58566372096342,
       "usdt": 6.1002875824731,
       "usdc": 4.636441183662745,
       "bnb": 4.313345254832438,
       "busd": 1.8129986165162193,
       "xrp": 1.599342716298421,
       "ada": 1.5305585267810695,
       "sol": 1.219428850647932,
       "dot": 0.7942309158004011
     },
     "market_cap_change_percentage_24h_usd": -0.05678062170905122,
     "updated_at": 1663057888
   }
 }
 */

// MARK: - MarketData
struct GlobalData: Codable {
    let data: MarketData?
}

// MARK: - DataClass
struct MarketData: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]?
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
//        if let item = totalMarketCap?.first(where: { (key, value) in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        
        if let item = totalMarketCap?.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume?.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage?.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}

