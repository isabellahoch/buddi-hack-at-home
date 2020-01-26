//
//  SignUpViewController.swift
//  OK BOOMER
//
//  Created by Isabella Hochschild on 1/25/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import CoreData

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func registerUser(_ sender: Any) {
        createUser(email: email.text!,password:password.text!)
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

            // we are creating a new ToDoCD object here, naming it toDo
            let newUser = User(entity: User.entity(), insertInto: context)

            // if the titleTextField has text, we will call that text titleText
                newUser.name = email.text!
                newUser.email = email.text!
            let user_id = email.text!+String(Int.random(in: 1000 ..< 9999))
                newUser.id = user_id

            try? context.save()
        }

        self.performSegue(withIdentifier: "postSignUp", sender: self)
    }
    
    func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil){
          Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
              if let e = error{
                  callback?(e)
                  return
              }
              callback?(nil)
          }
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
