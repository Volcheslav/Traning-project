//
//  GreenVC.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class GreenVC: UIViewController {

    @IBOutlet weak var greenLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func goToRoot(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        greenLabel.text = UserDefaults.standard.object(forKey: "str") as? String
        changeTabBarState(true)
    }
}

extension GreenVC: BarState {
    func changeTabBarState(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }
}
