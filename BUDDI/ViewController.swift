//
//  ViewController.swift
//  OK BOOMER
//
//  Created by Isabella Hochschild on 1/25/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit
import ApiAI
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        let item = messages[indexPath.row]
        cell.textLabel?.text = item.message
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13.0)
//        cell.textLabel?.backgroundColor = item.color
        cell.layer.cornerRadius=10
        cell.contentView.layer.masksToBounds = true
        cell.clipsToBounds = true
        cell.layer.borderColor = item.color.cgColor
        cell.layer.borderWidth = 5
        cell.textLabel?.frame = cell.frame.offsetBy(dx: 10, dy: 10);
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(messages[indexPath.row].avatar == "spacing") {
            return 10.0
        }

        return 50.0
    }

    private func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath as IndexPath)
            let item =  messages[indexPath.row]
            cell.textLabel?.text = item.message
            return cell
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var messageField: UITextField!
    
    let speechSynthesizer = AVSpeechSynthesizer()
     
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.label.text = text
            self.messages.append(ChatMessage(m: text, a:"me", c:.gray))
            self.messages.append(ChatMessage(m: " ", a:"spacing", c:.white))
//            self.tableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
            self.tableView.reloadData()
            if (self.messages.count > 5) {
                let indexPath = NSIndexPath(item: self.messages.count-1, section: 0)
                self.tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
            if(text.contains("OK, beginning navigation to")) {
                print("redirecting...")
                let start = text.index(text.startIndex, offsetBy: 27)
                let range = start..<text.endIndex
                let location = text[range]
                let originalUrl = "http://maps.apple.com/?q=\(location)"
                let urlString = originalUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let newURL = URL(string: urlString!)
                print(newURL)
                if (UIApplication.shared.canOpenURL(newURL!)) {
                    UIApplication.shared.openURL(newURL!)
                }
                else {
                    print("oh no")
                }
            }
            else if(text.contains("OK, setting a reminder for")) {
//                let start = text.index(text.startIndex, offsetBy: 26)
//                let range = start...text.index(of:text.split(separator:" ")[text.split(separator:"  ").count-1])
//                let topic = text[range]
//                let date = Date(text.split(separator:" ")[text.split(separator:" ").count-1])
//                CalendarService.addEventToCalendar(title: topic,
//                                                           description: "reminder from BUDDI app :)",
//                                                           startDate: date,
//                                                           endDate: date,
//                                                           completion: { (success, error) in
//                                                            if success {
//                                                                CalendarService.openCalendar(with: startDate)
//                                                            } else if let error = error {
//                                                                print(error)
//                                                            }
//                })
                guard let url = URL(string: "calshow://") else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }, completion: nil)
    }
    
    @IBAction func sendMessageFromKeyBoard() {
        let request = ApiAI.shared().textRequest()
        
        if let text = self.messageField.text, text != "" {
            print(text)
            request?.query = text
            messages.append(ChatMessage(m: text, a:"you", c:UIColor(red: 198/255, green: 230/255, blue: 199/255, alpha: 1) ))
            self.messages.append(ChatMessage(m: " ", a:"spacing", c:.white))
            tableView.reloadData()
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        let request = ApiAI.shared().textRequest()
        
        if let text = self.messageField.text, text != "" {
            print(text)
            request?.query = text
            messages.append(ChatMessage(m: text, a:"you", c:UIColor(red: 198/255, green: 230/255, blue: 199/255, alpha: 1) ))
            self.messages.append(ChatMessage(m: " ", a:"spacing", c:.white))
            tableView.reloadData()
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({ (request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.speech {
                self.speechAndText(text: textResponse)
            }
        }, failure: { (request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
    }
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.hideKeyboardWhenTappedAround()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        

        tableView.rowHeight = 50.0
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(self.keyboardNotification(notification:)),
        name: UIResponder.keyboardWillChangeFrameNotification,
        object: nil)
        
        tableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let indexPath = NSIndexPath(item: messages.count-1, section: 0)
//        tableView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            var endFrameY = endFrame?.origin.y ?? 0
//            endFrameY = endFrameY - 50
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
                
                    if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                        // adjust table view height
                        var tableViewFrame = tableView.frame;
                        tableViewFrame.size.height += 280.0;
                        tableView.frame = tableViewFrame;
//                        tableView.contentInset = UIEdgeInsets(top: 216.0, left: 0, bottom: 0, right: 0);
                        tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0, right: 0);
                    }
            } else {
                var newConstraint = endFrame?.size.height ?? 0.0
                newConstraint = newConstraint - 60
                self.keyboardHeightLayoutConstraint?.constant =  newConstraint
                
                if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                    // adjust table view height
                    var tableViewFrame = tableView.frame;
                    tableViewFrame.size.height -= 216.0;
                    tableView.frame = tableViewFrame;
                    tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0, bottom: 0.0, right: 0);
                }
            }
            UIView.animate(withDuration: duration,
                                       delay: TimeInterval(0),
                                       options: animationCurve,
                                       animations: { self.view.layoutIfNeeded() },
                                       completion: nil)
        }
    }
    
    
    var messages = [ ChatMessage(m: "hi, I'm Buddi! what can I help you with today?", a: "you", c: .gray), ChatMessage(m: " ", a:"spacing", c:.white)]
}

