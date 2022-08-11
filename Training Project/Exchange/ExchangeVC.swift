//
//  ExchangeVC.swift
//  Training Project
//
//  Created by VironIT on 8/10/22.
//

import UIKit

class ExchangeVC: UIViewController {
    
    private var exchangeInfo: Exchange?
    
    private var allCurrences: [Currency]?
    
    private var url: String?
    
    private var networkManager = NetworkManager()
    
//    @IBAction func startTouch(_ sender: UISegmentedControl) {
//        let index = currenciesSegmentegContr.selectedSegmentIndex
//         getCurrency(mode: index)
//         print(exchangeInfo?.name ?? "no")
//    }
    
    @IBOutlet private weak var currenciesSegmentegContr: UISegmentedControl!
    @IBOutlet private weak var exchngeLabel: UILabel!
    
    @IBAction private func showCurrency(_ sender: UISegmentedControl) {
       let index = currenciesSegmentegContr.selectedSegmentIndex
        getCurrency(mode: index)
        //print(exchangeInfo?.name ?? "no")
    }
    @IBAction private func getExchangeInfo(_ sender: UIButton) {
        getUSD(from: url!)
       guard let currentRate = exchangeInfo?.rate else { return }
        self.exchngeLabel.text = String(currentRate)
        
// print(self.allCurrences?.map{$0.abbreviation} ?? "no")
    }
    
    private func getCurrency(mode: Int) {
        guard let currCode = currenciesSegmentegContr.titleForSegment(at: mode) else {
            return
        }
        guard var urlComponents = URLComponents(string: APIConst.baseURL + currCode) else { return }
        urlComponents.queryItems = [URLQueryItem(name: APIConst.mode, value: "2")]
        guard let url = urlComponents.url else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                print("Error")
                return
            }
            
            var result: Exchange?
            
            do {
                try result = JSONDecoder().decode(Exchange.self, from: data)
            } catch {
                print("error")
            }
            
            guard let json = result else {
                return
            }
            
            DispatchQueue.main.async {
                self.exchngeLabel.text = String(json.rate)
            }
            self.exchangeInfo = json
            
        })
        task.resume()
        
    }
    
    private func getUSD(from url: String) {
        guard var urlComponents = URLComponents(string: APIConst.baseURL + "usd") else { return }
        urlComponents.queryItems = [URLQueryItem(name: APIConst.mode, value: "2")]
        guard let url = urlComponents.url else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("Error")
                return
            }
            
            var result: Exchange?
            
            do {
                try result = JSONDecoder().decode(Exchange.self, from: data)
            } catch {
                print("error")
            }
            
            self.exchangeInfo = result
            DispatchQueue.main.async {
                self.exchngeLabel.text = String(result!.rate)             }
            
        })
        task.resume()
    }
    
    private func getAllMoney(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                print("no info")
                return
            }
            
            var result: [Currency]?
            // var allMoney: [Currency] = []
            
            do {
                try result = JSONDecoder().decode([Currency].self, from: data)
            } catch {
                print("cant decode")
            }
            
            guard let json = result else {
                return
            }
            self.allCurrences = json
        
        })
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.url = "https://www.nbrb.by/api/exrates/rates/usd?parammode=2"
        getAllMoney(from: "https://www.nbrb.by/api/exrates/currencies")
        //networkManager.getUSD()
        //networkManager.getCurrency(for: "eur")
        //getUSD(from: self.url!)
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
