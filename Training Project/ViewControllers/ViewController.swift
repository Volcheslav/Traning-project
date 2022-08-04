//
//  ViewController.swift
//  Training Project
//
//  Created by VironIT on 7/26/22.
//

import UIKit

class ViewController: UIViewController{
    
    private var textFromAlert: String?
    
    @IBOutlet weak private var myBackground: UIImageView!
    
    @IBOutlet weak private var myTitle: UILabel!
    
    @IBOutlet weak private var myText: UILabel!
    
    @IBOutlet weak private var myTextField: UITextField!
    
    @IBOutlet weak private var myErrorLabel: UILabel!
    
    @IBOutlet weak private var myButton: UIButton!
    
    var userDefaults = UserDefaults.standard
    
    // MARK: View load functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        myTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        swipeObs()
    }
    
    // MARK: Segue prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabC = segue.destination as? UITabBarController {
            if var vcFromTab = tabC.viewControllers?.first as? MySecondViewController{
                vcFromTab.setText(textFromAlert ?? "no text")
            }
            if let vcFromNav = tabC.viewControllers?.last as? UINavigationController {
                if var purpleVC = vcFromNav.topViewController as? PurpleVC {
                    purpleVC.setText(textFromAlert ?? "no text")
                }
            }
        }
    }
    
    // MARK: Unwined segue
    
    @IBAction func goHome(_ sender: UIStoryboardSegue) {
    }
    
    // MARK: Navigation
    
    @objc private func swipeOnLeft(gest: UISwipeGestureRecognizer) {
        guard gest.direction == .right else {
            return
        }
        let storybord = UIStoryboard(name: "ThirdScreen", bundle: nil)
        guard let viewController = storybord.instantiateViewController(identifier: "thirdVC") as? ThirdVC else {
            return
        }
        show(viewController, sender: nil)
    }
    
    private func swipeObs(){
        let goLeftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeOnLeft))
        goLeftSwipe.direction = .right
        self.myBackground.addGestureRecognizer(goLeftSwipe)
    }
    
    @IBAction func goToSecondVC(_ sender: UIButton) {
        if myTextField.hasText {
            if UserDefaults.standard.object(forKey: "str") != nil{
                UserDefaults.standard.removeObject(forKey: "str")
            }
            userDefaults.set(myTextField.text, forKey: "str")
            showAlertWindow()
            // performSegue(withIdentifier: "toSecondVC", sender: self)
            
        } else {
            let alertTextField = UIAlertController(title: "Error", message: "Type some text!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertTextField.addAction(okButton)
            present(alertTextField, animated: true)
        }
        
    }
    
    // MARK: Alert windows
    
    private func showAlertWindow() {
        let alert = UIAlertController(title: "Print something", message: "No numbers", preferredStyle: .alert)
        //let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            if let hasText = alert.textFields?.first?.hasText {
                switch hasText {
                case true:
                    let numChexk = alert.textFields!.first!.text!
                    let nums = numChexk.hasNumbers()
                    if nums {
                        self.showAlertIfNumbers()
                    } else {
                        self.textFromAlert = numChexk
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)}
                default:
                    self.showAlertText()
                }
                
            }
        }
        alert.addAction(okAction)
        alert.addCancelAction()
        alert.addTextField(configurationHandler: {$0.placeholder = "enter something"})
        present(alert, animated: true)
        
    }
    
    private func showAlertIfNumbers() {
        let alert3 = UIAlertController(title: "Alert!", message: "No numbers!", preferredStyle: .alert)
        alert3.addAction(UIAlertAction(title: "Again", style: .default){[unowned self] _ in self.showAlertWindow()})
        alert3.addCancelAction()
        self.present(alert3, animated: true, completion: nil)
    }
    
    private func showAlertText(){
        let alert2 = UIAlertController(title: "Alert!", message: "You must type a text", preferredStyle: .alert)
        alert2.addAction(UIAlertAction(title: "Ok", style: .default){[unowned self] _ in self.showAlertWindow()})
        alert2.addCancelAction()
        self.present(alert2, animated: true)
    }
    
    // MARK: Random shit
    
    @IBAction private func doSomething(_ sender: Any) {
        self.myErrorLabel.isHidden = myTextField.hasText
        //print("tap")
    }
    
    
    @IBAction private func changeErrorLabelState(_ sender: UITapGestureRecognizer) {
        //print("tap")
        self.myErrorLabel.isHidden = true
        self.myTextField.text = nil
    }
    
    // MARK: Hiding keybord functions
    
    private func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
 
    


}


extension String {
    func hasNumbers() -> Bool {
        guard !self.isEmpty else {
            return true
        }
        let hasNums = self.map{$0.isNumber}
        return hasNums.contains(true) ? true : false
    }
}

extension UIAlertController {
    func addCancelAction () {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
