//
//  MySecondViewController.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class MySecondViewController: UIViewController {
    internal var someLabelText: String?

    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var secondScreenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let text = UserDefaults.standard.object(forKey: "str") as? String {
//            self.secondScreenLabel.text = text
//        }
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var vc = segue.destination as? OrangeVC {
            vc.setText(someLabelText ?? "no text")
        }
    }
    
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        alertLabel.text = someLabelText
        if let text = UserDefaults.standard.object(forKey: "str") as? String {
            self.secondScreenLabel.text = text
        }
    }

}

extension MySecondViewController: LabelProtocol {}
