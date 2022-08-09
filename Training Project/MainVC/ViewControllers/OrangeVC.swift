//
//  OrangeVC.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class OrangeVC: UIViewController {
    var someLabelText: String?

    @IBOutlet weak var alertTextLabel: UILabel!
    @IBOutlet weak var orangeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        orangeLabel.text = UserDefaults.standard.object(forKey: "str") as? String
        alertTextLabel.text = someLabelText

    }

//    func setText(_ someText:String) {
//        self.someLabelText = someText
//    }

}

extension OrangeVC: LabelProtocol {
}
