//
//  ViewController.swift
//  Remote Learning Assignment - Week 3
//
//  Created by 姜旦旦 on 2019/1/26.
//  Copyright © 2019 姜旦旦. All rights reserved.
//

import UIKit


var allAccount: [String:String] = ["appwork_school@gmail.com": "1234"]


class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var accountTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var checkTF: UITextField!
    @IBOutlet weak var checkLabel: UILabel!
    var abc = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLabel.textColor = UIColor(white: 0, alpha: 0.3)
        checkTF.isEnabled = false
        checkTF.backgroundColor = UIColor(white: 0, alpha: 0.3)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showAlertwith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func bottom(_ sender: UIButton) {
      
       
       if abc == 0 {
            do {
                try logIn()
            } catch LogInError.logInFail {
                showAlertwith(title: "Error", message: "Login fail")
            } catch let error {
                fatalError("\(error)")
            }
  
     
        } else {
            do {
                try signUp()
            } catch SignUpError.accountEmpty{
               showAlertwith(title: "Error", message: "Account should not be empty")
            }
            catch SignUpError.passwordEmpty{
                showAlertwith(title: "Error", message: "Password should not be empty")
            }
            catch SignUpError.checkwordEmpty{
                showAlertwith(title: "Error", message: "Check password should not be empty")
            }
            catch SignUpError.signupFail{
                showAlertwith(title: "Error", message: "Signup fail")
            }
            catch SignUpError.accountEx {
                showAlertwith(title: "Error", message: "Your account has been existence")
            }
            catch let error {
                fatalError("\(error)")
            }
        
        }
    }
    
    @IBAction func logInSignUp(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            checkLabel.textColor = UIColor(white: 0, alpha: 0.3)
            checkTF.isEnabled = false
            checkTF.backgroundColor = UIColor(white: 0, alpha: 0.3)
            checkTF.text = nil
            passwordTF.text = nil
            accountTF.text = nil
        }
        else {
            checkLabel.textColor = UIColor(white: 0, alpha: 1)
            checkTF.isEnabled = true
            checkTF.backgroundColor = UIColor(white: 255, alpha: 1)
            
            passwordTF.text = nil
            accountTF.text = nil
            
        }
             abc = sender.selectedSegmentIndex
    }
  
  
    enum SignUpError: Error {
        case accountEmpty
        case passwordEmpty
        case checkwordEmpty
        case signupFail
        case accountEx
    }
    
    enum LogInError: Error {
        case logInFail
    }
 
    func signUp() throws {
        if accountTF.text?.isEmpty == true || accountTF.text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
            throw SignUpError.accountEmpty
        }
        if passwordTF.text?.isEmpty == true || passwordTF.text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
            throw SignUpError.passwordEmpty
        }
        if checkTF.text?.isEmpty == true || checkTF.text?.trimmingCharacters(in: .whitespaces).isEmpty == true {
            throw SignUpError.checkwordEmpty
        }
        if passwordTF.text != checkTF.text {
            throw SignUpError.signupFail
        }
        if allAccount["\(accountTF.text!)"] != nil
        {
             throw SignUpError.accountEx
        }
        else {
             showAlertwith(title: "Congratulations", message: "Your account has been creat")
            allAccount["\(accountTF.text!)"] = passwordTF.text!
        }
        
        
    }
  
    func logIn() throws {
        
        if allAccount["\(String(describing: accountTF.text!))"] == passwordTF.text! {
            showAlertwith(title: "Welcome", message: "Hi.Welcome back. \(accountTF.text!)")
            print("Hi.Welcome back. \(accountTF.text!)")
        } else {
            throw LogInError.logInFail
        }
        
    }
    
}
