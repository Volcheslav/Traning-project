//
//  ExchangeVC.swift
//  Training Project
//
//  Created by VironIT on 8/10/22.
//

import UIKit

class ExchangeVC: UIViewController {
    
    @IBOutlet private weak var exchngeLabel: UILabel!
    
    @IBAction private func getExchangeInfo(_ sender: UIButton) {
        getUSD(from: url!)
//        guard let currentRate = exchangeInfo?.rate else {
//            return
//        }
        self.exchngeLabel.text = String(exchangeInfo!.rate)
        
       // print(self.allCurrences?.map{$0.id} ?? "no")
    }
    
    private var exchangeInfo: Exchange?
    
    private var allCurrences: [Currency]?
    
    private var url: String?
    
    private func getUSD(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
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
            self.exchangeInfo = json
//            print(json.rate)
//            print(json.scale)
//            print(json.abbreviation)
//            print(json.date)
        
        })
        task.resume()
    }
    
    private func getAllMoney(from url: String){
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else {
                print("no info")
                return
            }
            
            
            var result: [Currency]?
            //var allMoney: [Currency] = []
            
            do {
                try result = JSONDecoder().decode([Currency].self, from: data)
            } catch {
                print("cant decode")
            }
            
            guard let json = result else {
                return
            }
            self.allCurrences = json
//            print(json.rate)
//            print(json.scale)
//            print(json.abbreviation)
//            print(json.date)
        
        })
        task.resume()
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.url = "https://www.nbrb.by/api/exrates/rates/usd?parammode=2"
        getAllMoney(from: "https://www.nbrb.by/api/exrates/currencies")
        getUSD(from: self.url!)
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
