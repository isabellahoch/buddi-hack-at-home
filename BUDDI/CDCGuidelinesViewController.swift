//
//  CDCGuidelinesViewController.swift
//  BUDDI
//
//  Created by Isabella Hochschild on 3/29/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit

class CDCGuidelinesViewController: UIViewController {
    
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.numberOfLines = 0
        label.attributedText = bulletPointList(strings: ["Stay home.","Wash your hands often.", "Avoid close contact (6 feet, which is about two arm lengths) with people who are sick.", "Clean and disinfect frequently touched services.","Avoid all cruise travel and non-essential air travel.","Call your healthcare professional if you have concerns about COVID-19 and your underlying condition or if you are sick."])
    }
    
    func bulletPointList(strings: [String]) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 15
        paragraphStyle.lineSpacing = 12
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15)]

        let stringAttributes = [
            NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.thin),
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
