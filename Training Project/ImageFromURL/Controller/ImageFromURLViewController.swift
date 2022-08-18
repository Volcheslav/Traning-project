//
//  ImageFromURLViewController.swift
//  Training Project
//
//  Created by VironIT on 8/17/22.
//
import RealmSwift
import UIKit

class ImageFromURLViewController: UIViewController {
    // swiftlint:disable all
    let realm = try! Realm()
    var items: Results<PersonRealm>!
    // swiftlint:enable all
    private var person: PersonModel?
    private var name: String?
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var fromURLImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = realm.objects(PersonRealm.self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fromURLImageView.loadFrom(URLAddress: items.last!.imageURL)
        self.nameLabel.text = "\(items.last!.name) \(items.last!.surname)"
        getImageURL()
        getNameFromURL()
    }
    
    @IBAction private func saveInfoToRealm(_ sender: UIButton) {
        guard let name = nameLabel.text?.components(separatedBy: .whitespaces).first,
              let surname = nameLabel.text?.components(separatedBy: .whitespaces).last,
              let imageURL = person?.imageURL else {
            print("Cant save")
            return
        }
        let person = PersonRealm()
        person.name = name
        person.surname = surname
        person.imageURL = imageURL
        // swiftlint:disable all
        try! realm.write{
            realm.add(person)
            print("succes")
        }
        // swiftlint:enable all
    }
    
    @IBAction private func getPersonInfoFromURL(_ sender: UIButton) {
        getImageURL()
        getNameFromURL()
        self.fromURLImageView.loadFrom(URLAddress: person!.imageURL)
        self.nameLabel.text = self.name
        
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
        guard let url = URL(string: URLAddress) else { return }

        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let imageData = try? Data(contentsOf: url),
                  let loadedImage = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self?.image = loadedImage
            }
        }
    }
}
