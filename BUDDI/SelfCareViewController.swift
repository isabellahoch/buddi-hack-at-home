//
//  SelfCareViewController.swift
//  BUDDI
//
//  Created by Isabella Hochschild on 3/29/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit

class SelfCareViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.numberOfLines = 0
        label.attributedText = bulletPointList(strings: ["Take breaks from watching, reading, or listening to news stories and social media. Hearing about the pandemic repeatedly can be upsetting.","Take care of your body. Take deep breaths, stretch, or meditate. Try to eat healthy, well-balanced meals, exercise regularly, get plenty of sleep, and avoid alcohol and drugs.","Make time to unwind. Try to do some other activities you enjoy.","Connect with others. Talk with people you trust about your concerns and how you are feeling.","Call your healthcare provider if stress gets in the way of your daily activities for several days in a row.","If you, or someone you care about, are feeling overwhelmed with emotions like sadness, depression, or anxiety, or feel like you want to harm yourself or others call 911 or Substance Abuse and Mental Health Services Administration’s (SAMHSA’s) Disaster Distress Helpline: 1-800-985-5990 or text TalkWithUs to 66746. (TTY 1-800-846-8517)"])
    }
    
    func bulletPointList(strings: [String]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 8
        paragraphStyle.lineSpacing = 18
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15)]

        let stringAttributes = [
            NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.thin),
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]

        let string = strings.map({ "•\t\($0)" }).joined(separator: "\n")

        return NSAttributedString(string: string,
                                  attributes: stringAttributes)
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
