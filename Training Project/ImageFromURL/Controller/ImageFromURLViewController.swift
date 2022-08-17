//
//  ImageFromURLViewController.swift
//  Training Project
//
//  Created by VironIT on 8/17/22.
//

import UIKit

class ImageFromURLViewController: UIViewController {
    
    private var person: PersonModel?
    private var name: String?
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var fromURLImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getImageURL()
        getNameFromURL()
    }
    
    @IBAction private func getPersonInfoFromURL(_ sender: UIButton) {
        self.fromURLImageView.loadFrom(URLAddress: person!.imageURL)
        self.nameLabel.text = self.name
        getImageURL()
        getNameFromURL()
    }
    
    @IBAction private func printinfo(_ sender: UIButton) {
        guard let info = self.name else {
            print("no url")
            return
        }
        print(info)
    }
    
    private func getNameFromURL() {
        let url = URL(string: PersonURL.nameURL)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                print("\n MY LOG: \(error.debugDescription)")
                return
            }
            typealias Welcome = [String]
            var result: [String]?
            
            do {
                try result = JSONDecoder().decode(Welcome.self, from: data)
            } catch {
                print("error decoding name")
            }
            self.name = result?.first
            
        })
        task.resume()
    }
    
    private func getImageURL() {
        let url = URL(string: PersonURL.baseURL)!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url, completionHandler: {data, _, error in
            guard let data = data, error == nil else {
                print(error.debugDescription)
                return
            }
            
            var result: PersonModel?
            
            do {
                try result = JSONDecoder().decode(PersonModel.self, from: data)
            } catch {
                print("error decoding image")
            }
            self.person = result
            
        })
        task.resume()
        
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

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
