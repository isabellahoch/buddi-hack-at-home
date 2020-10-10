//
//  ContactViewController.swift
//  OK BOOMER
//
//  Created by Isabella Hochschild on 1/25/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController {

    @IBOutlet weak var trustedContact: UILabel!
    @IBOutlet weak var textboxContact: UITextField!
    @IBOutlet weak var msgText: UITextView!
       
      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
      }
      
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let finalContact = textboxContact.text {
          trustedContact.text = finalContact
        }
      }
  
    @IBAction func makeCall(_ sender: UIButton) {
        var url:NSURL = NSURL(string : "tel://"+(trustedContact.text ?? String(9259673264))!)!
        UIApplication.shared.openURL(url as URL)
      }
       
    @IBAction func sendText(_ sender: UIButton) {
        if MFMessageComposeViewController.canSendText(){
          let controller = MFMessageComposeViewController()
          controller.body = self.msgText.text
          controller.recipients = [self.textboxContact.text!]
            controller.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
           
          self.present(controller, animated: true, completion: nil)
           
        }
        else{
          print("cannot send text")
        }
      }

}
