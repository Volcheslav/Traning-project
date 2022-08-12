//
//  ViewController.swift
//  Training Project
//
//  Created by VironIT on 7/26/22.
//
// import KeychainSwift
import UIKit

final class ViewController: UIViewController {

    private var textFromAlert: String?
    
//    private var userDefaults = UserDefaults.standard
//
//    private var keyChain = KeychainSwift()
    
    private var username: String?

    @IBOutlet private weak var myBackground: UIImageView!

    @IBOutlet private weak var myTitle: UILabel!

    @IBOutlet private weak var myText: UILabel!

    @IBOutlet private weak var myTextField: UITextField!

    @IBOutlet private weak var myErrorLabel: UILabel!

    @IBOutlet private weak var myButton: UIButton!

    // MARK: View load functions

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        myTextField.placeholder = "Enter your username"
        myTextField.delegate = self
//        UserDefaults.standard.removeObject(forKey: "dimon")
//        UserDefaults.standard.removeObject(forKey: "vlad")
//        UserDefaults.standard.removeObject(forKey: "ivan")
//        UserDefaults.standard.removeObject(forKey: "masha")
//        UserDefaults.standard.removeObject(forKey: "alex")
//
//        keyChain.clear()
//        keyChain.delete("dimon")
//        keyChain.delete("vlad")
//        keyChain.delete("ivan")
//        keyChain.delete("masha")
//        keyChain.delete("alex")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.myTextField.text = nil
        swipeObs()
    }

    // MARK: Segue prepare

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tabC = segue.destination as? UITabBarController {
            if var vcFromTab = tabC.viewControllers?.first as? MySecondViewController {
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

    @IBAction private func goHome(_ sender: UIStoryboardSegue) {
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

    private func swipeObs() {
        let goLeftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeOnLeft))
        goLeftSwipe.direction = .right
        self.myBackground.addGestureRecognizer(goLeftSwipe)
    }
// Сделать функцию для перехода
    @IBAction private func goToAnimationVC(_ sender: UIButton) {
        let storybord = UIStoryboard(name: "Animation", bundle: nil)
        guard let viewController = storybord.instantiateViewController(identifier: "animationVC") as? AnimationVC else {
            return
        }
        show(viewController, sender: self)
    }

    @IBAction private func goToExchangeVC(_ sender: UIButton) {
        let storybord = UIStoryboard(name: "Exchange", bundle: nil)
        guard let viewController = storybord.instantiateViewController(identifier: "exchangeVC") as? ExchangeVC else {
            return
        }
        show(viewController, sender: self)
    }
    
    @IBAction private func goToSecondVC(_ sender: UIButton) {
       goTo2VCAfterPassCheck()
    }
    
    private func goTo2VCAfterPassCheck() {
        guard myTextField.hasText else {
            AlertWindows.showAlertText(window: {}, message: "Type your username!", viewcontroller: self)
            return
        }
            self.username = myTextField.text!.trimmingCharacters(in: .whitespaces).lowercased()
            Security.setUsernameInDefalts(username: self.username!, getPinAlert: showGetPasswordAlert, setPinAlert: showSetPasswordAlert)

    }

    // MARK: Alert windows
    
    private enum AlertWindowText: String {
        case pin = "PIN"
        case type = "Type your PIN!"
        case ok = "OK"
        case again = "Again"
        case set = "Set your PIN, new user"
        case succes = "Succes!!"
        case pinError = "Incorrect PIN!"
    }
    
    private func showSetPasswordAlert() {
        let alert = UIAlertController(title: AlertWindowText.pin.rawValue, message: AlertWindowText.set.rawValue, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { $0.placeholder = AlertWindowText.type.rawValue; $0.keyboardType = .numberPad })
        alert.addCancelAction()
        let okAction = UIAlertAction(title: AlertWindowText.ok.rawValue, style: .default) {[unowned self] _ in
            if let hasText = alert.textFields?.first?.hasText {
                switch hasText {
                case true:
                    Security.setPassword(password: alert.textFields!.first!.text!, username: self.username!)
                    AlertWindows.showAlertText(window: showGetPasswordAlert, message: AlertWindowText.succes.rawValue, viewcontroller: self)
                default:
                    AlertWindows.showAlertText(window: showSetPasswordAlert, message: AlertWindowText.type.rawValue, viewcontroller: self)
                }
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func showGetPasswordAlert() {
        let alert = UIAlertController(title: AlertWindowText.pin.rawValue, message: AlertWindowText.type.rawValue, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { $0.placeholder = AlertWindowText.type.rawValue; $0.keyboardType = .numberPad; $0.isSecureTextEntry = true })
      
        alert.addCancelAction()
        let okAction = UIAlertAction(title: AlertWindowText.ok.rawValue, style: .default) {[unowned self] _ in
            if let hasText = alert.textFields?.first?.hasText {
                switch hasText {
                case true:
                    if Security.checkPassword(enteredPassword: alert.textFields!.first!.text!, username: self.username!) {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    } else {
                        AlertWindows.showAlertText(window: showGetPasswordAlert, message: AlertWindowText.pinError.rawValue, viewcontroller: self, okButtonTitle: AlertWindowText.again.rawValue)
                    }
                default:
                    AlertWindows.showAlertText(window: showGetPasswordAlert, message: AlertWindowText.type.rawValue, viewcontroller: self, okButtonTitle: AlertWindowText.again.rawValue)
                }
            }
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
//    private func showAlertText(window: @escaping () -> Void, message: String) {
//        let alert2 = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
//        alert2.addAction(UIAlertAction(title: "Ok", style: .default) { _ in window() })
//        alert2.addCancelAction()
//        self.present(alert2, animated: true)
//    }

//    private func showAlertWindow() {
//        let alert = UIAlertController(title: "Print something", message: "No numbers", preferredStyle: .alert)
//        // let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        let okAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
//            if let hasText = alert.textFields?.first?.hasText {
//                switch hasText {
//                case true:
//                    let numChexk = alert.textFields!.first!.text!
//                    let nums = numChexk.hasNumbers()
//                    if nums {
//                        self.showAlertIfNumbers()
//                    } else {
//                        self.textFromAlert = numChexk
//                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)}
//                default:
//                    self.showAlertText(window: showAlertWindow, message: "Type a text!")
//                }
//
//            }
//        }
//        alert.addAction(okAction)
//        alert.addCancelAction()
//        alert.addTextField(configurationHandler: { $0.placeholder = "enter something" })
//        present(alert, animated: true)
//
//    }

//    private func showAlertIfNumbers() {
//        let alert3 = UIAlertController(title: "Alert!", message: "No numbers!", preferredStyle: .alert)
//        alert3.addAction(UIAlertAction(title: "Again", style: .default) { [unowned self] _ in self.showAlertWindow() })
//        alert3.addCancelAction()
//        self.present(alert3, animated: true, completion: nil)
//    }

    // MARK: Random shit

    @IBAction private func doSomething(_ sender: Any) {
        self.myErrorLabel.isHidden = myTextField.hasText
        // print("tap")
    }

    @IBAction private func changeErrorLabelState(_ sender: UITapGestureRecognizer) {
        // print("tap")
        self.myErrorLabel.isHidden = true
        self.myTextField.text = nil
    }

    // MARK: Hiding keybord functions

    private func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard)
        )
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissMyKeyboard() {
        view.endEditing(true)
    }

}

extension String {
    func hasNumbers() -> Bool {
        guard !self.isEmpty else {
            return true
        }
        let hasNums = self.map { $0.isNumber }
        return hasNums.contains(true) ? true : false
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.goTo2VCAfterPassCheck()
        return true
    }
}
