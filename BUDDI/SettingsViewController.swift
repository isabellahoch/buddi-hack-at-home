//
//  SettingsViewController.swift
//  OK BOOMER
//
//  Created by Isabella Hochschild on 1/25/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = Auth.auth().currentUser?.email

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOutTapped(_ sender: Any) {
        func signOut() -> Bool{
            do{
                try Auth.auth().signOut()
                return true
            }catch{
                return false
            }
        }
        signOut()
        self.performSegue(withIdentifier: "userLoggedOut", sender: nil)
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
