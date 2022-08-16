//
//  ThirdVC.swift
//  Training Project
//
//  Created by VironIT on 8/1/22.
//

import UIKit

class ThirdVC: UIViewController {

    // private var textAndImageTuples: [(String, UIImage)] = [("The big bang", UIImage(named: "big bang")!)]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction private func goToCollection(_ sender: UIButton) {
        let storybord = UIStoryboard(name: "Collection", bundle: nil)
        
        guard let viewController = storybord.instantiateViewController(identifier: "picColVC") as? PicCollection else {
            return
        }
        let nc = UINavigationController(rootViewController: viewController)
        nc.modalPresentationStyle = .fullScreen
       show(nc, sender: nil)
    }

    @IBAction private func goToThirdVC (sender: UIStoryboardSegue) {}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
