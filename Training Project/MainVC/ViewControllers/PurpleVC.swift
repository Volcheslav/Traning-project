//
//  PurpleVC.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class PurpleVC: UIViewController {
    var someLabelText: String?

    @IBOutlet weak var purpleLabel: UILabel!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var vcBlue = segue.destination as? BlueVC {
            vcBlue.setText(someLabelText ?? "no text")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        changeNavBarState(true)
       // print(someLabelText!)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        changeNavBarState(false)
        // changeTabBarState(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        purpleLabel.text = UserDefaults.standard.object(forKey: "str") as? String
        changeNavBarState(true)
        changeTabBarState(false)
    }

}

extension PurpleVC: LabelProtocol {}

extension PurpleVC: NavbarAndTabBar {

    func changeTabBarState(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }

    func changeNavBarState(_ isHidden: Bool) {
        self.navigationController?.isNavigationBarHidden = isHidden
    }
}
