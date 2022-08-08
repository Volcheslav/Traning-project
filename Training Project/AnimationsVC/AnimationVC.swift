//
//  AnimationVC.swift
//  Training Project
//
//  Created by VironIT on 8/8/22.
//

import UIKit

class AnimationVC: UIViewController {

    @IBOutlet weak var heightSliderSlider: UISlider!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    @IBAction func heightSlider(_ sender: UISlider) {
        let scale = sender.value
        let transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
        //        UIView.animate(withDuration: 0.1, animations: {[unowned self] in
//            self.image.center.x = CGFloat(sender.value)
//        })
        
        self.image.transform = transform
    }
    
    
    @IBAction func upPic(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.y -= 5 })
    }
    
    @IBAction func dowPIC(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.y += 5 })
    }
    
    @IBAction func leftPic(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.x -= 5 })
    }
    
    @IBAction func rightPic(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.x += 5 })
    }
    
    @IBAction func changeX(_ sender: UIStepper) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
            self?.image.transform = CGAffineTransform(scaleX: CGFloat(sender.value / 10), y: CGFloat(sender.value / 10))
        } )
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
