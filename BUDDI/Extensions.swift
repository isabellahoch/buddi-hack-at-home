//
//  Extensions.swift
//  OK BOOMER
//
//  Created by Isabella Hochschild on 1/25/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
       view.endEditing(true)
    }
}

//extension UIColor {
//    public convenience init?(hex: String) {
//        let r, g, b, a: CGFloat
//
//        if hex.hasPrefix("#") {
//            let start = hex.index(hex.startIndex, offsetBy: 1)
//            let hexColor = String(hex[start...])
//
//            if hexColor.count == 8 {
//                let scanner = Scanner(string: hexColor)
//                var hexNumber: UInt64 = 0
//
//                if scanner.scanHexInt64(&hexNumber) {
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                    a = CGFloat(hexNumber & 0x000000ff) / 255
//
//                    self.init(red: r, green: g, blue: b, alpha: a)
//                    return
//                }
//            }
//        }
//
//        return nil
//    }
//}

import EventKit

final class CalendarService {

  class func openCalendar(with date: Date) {
    guard let url = URL(string: "calshow:\(date.timeIntervalSinceReferenceDate)") else {
      return
    }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  class func addEventToCalendar(title: String,
                                description: String?,
                                startDate: Date,
                                endDate: Date,
                                completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
    DispatchQueue.global(qos: .background).async { () -> Void in
      let eventStore = EKEventStore()

      eventStore.requestAccess(to: .event, completion: { (granted, error) in
        if (granted) && (error == nil) {
          let event = EKEvent(eventStore: eventStore)
          event.title = title
          event.startDate = startDate
          event.endDate = endDate
          event.notes = description
          event.calendar = eventStore.defaultCalendarForNewEvents
          do {
            try eventStore.save(event, span: .thisEvent)
          } catch let e as NSError {
            DispatchQueue.main.async {
              completion?(false, e)
            }
            return
          }
          DispatchQueue.main.async {
            completion?(true, nil)
          }
        } else {
          DispatchQueue.main.async {
            completion?(false, error as NSError?)
          }
        }
      })
    }
  }
}
