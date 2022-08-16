//
//  MySecondViewController.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class MySecondViewController: UIViewController {
    internal var someLabelText: String?

    @IBOutlet private weak var alertLabel: UILabel!
    @IBOutlet private weak var secondScreenLabel: UILabel!

    @IBAction private func goToTableRealm(_ sender: UIButton) {
        let storybord = UIStoryboard(name: "TableRealm", bundle: nil)
        let tabVC = storybord.instantiateViewController(identifier: "realmTab") as TableRealm
        show(tabVC, sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let text = UserDefaults.standard.object(forKey: "str") as? String {
//            self.secondScreenLabel.text = text
//        }
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var viewController = segue.destination as? OrangeVC {
            viewController.setText(someLabelText ?? "no text")
        }
    }

    @IBAction private func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        alertLabel.text = someLabelText
        if let text = UserDefaults.standard.object(forKey: "str") as? String {
            self.secondScreenLabel.text = text
        }
    }

}

extension MySecondViewController: LabelProtocol {}
