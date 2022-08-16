//
//  AnimationVC.swift
//  Training Project
//
//  Created by VironIT on 8/8/22.
//

import UIKit

class AnimationVC: UIViewController {

    @IBOutlet private weak var rotationSlider: UISlider!
    @IBOutlet private weak var heightSliderSlider: UISlider!
    @IBOutlet private weak var image: UIImageView!

    @IBOutlet private weak var widthSlider: UISlider!
    @IBOutlet private weak var widthConstraint: NSLayoutConstraint!

    @IBAction private func heightSlider(_ sender: UISlider) {
        let scale = sender.value
        let transform = CGAffineTransform(scaleX: CGFloat(self.widthSlider.value), y: CGFloat(scale))
        //        UIView.animate(withDuration: 0.1, animations: {[unowned self] in
//            self.image.center.x = CGFloat(sender.value)
//        })

        self.image.transform = transform
        self.image.frame.applying(transform)

    }

    @IBAction private func changeWidth(_ sender: UISlider) {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            self?.image.transform = CGAffineTransform(
                scaleX: CGFloat(sender.value),
                y: CGFloat((self?.heightSliderSlider.value)!)
            )
//            self?.image.transform = (self?.image.transform.scaledBy(x: CGFloat(sender.value / 10), y: 1))!
        })
    }

    @IBAction private func rotatePic(_ sender: UISlider) {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            let transform = CGAffineTransform(rotationAngle: CGFloat(sender.value))
            self?.image.transform = transform
            self?.image.frame.applying(transform)

//            self?.image.transform = (self?.image.transform.rotated(by: CGFloat(sender.value / 10)))!
        })
    }

    @IBAction private func upPic(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in

                        self?.image.center.y -= 5 })
    }

    @IBAction private func dowPIC(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.y += 5 })
    }

    @IBAction private func leftPic(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.x -= 5 })
    }

    @IBAction private func rightPic(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
                        self?.image.center.x += 5 })
    }

    @IBAction private func changeX(_ sender: UIStepper) {
        UIView.animate(withDuration: 0.1, animations: {[weak self] in
            self?.image.transform = CGAffineTransform(scaleX: CGFloat(sender.value / 10), y: CGFloat(sender.value / 10))
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rotationSlider.maximumValue = Float.pi * 2
        rotationSlider.minimumValue = -(Float.pi) * 2

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
