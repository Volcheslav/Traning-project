//
//  BlueVC.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class BlueVC: UIViewController {
    internal var someLabelText: String?

    @IBOutlet private weak var blueLabel: UILabel!
    @IBOutlet private weak var blueLabel2: UILabel!

    @IBAction private func goToRoot(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        blueLabel.text = UserDefaults.standard.object(forKey: "str") as? String
        changeTabBarState(true)
        blueLabel2.text = someLabelText
    }

}

extension BlueVC: LabelProtocol {}

extension BlueVC: BarState {

    func changeTabBarState(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }

}
