//
//  GroceryViewController.swift
//  BUDDI
//
//  Created by Isabella Hochschild on 3/28/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import UIKit
class GroceryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var hoursText: UILabel!
  var list = ["Big Lots", "Costco", "Fry's Food Stores", "FoodMaxx", "Ralphs", "Safeway", "Target", "Walgreens", "Walmart", "Whole Foods Market"]
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
        
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
    scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: hoursText.bottomAnchor).isActive = true
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
   
   
  public func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1
     
  }
   
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
     
    return list.count
     
  }
   
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     
    self.view.endEditing(true)
    return list[row]
     
  }
   
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     
    self.textBox.text = self.list[row]
    self.dropDown.isHidden = false
     
  }
   
  func textFieldDidBeginEditing(_ textField: UITextField) {
     
    if textField == self.textBox {
      self.dropDown.isHidden = false
      //if you dont want the users to se the keyboard type:
       
      textField.endEditing(true)
    }
     
  }
    
  @IBAction func checkHours(_ sender: Any) {
    if textBox.text == "Big Lots" {
      hoursText.text = "All of our stores are reserving the first hour of each day for our senior citizens and those most vulnerable to this virus."
    }
    if textBox.text == "Costco" {
      hoursText.text = "Costco will open its doors to members 60 years and older every Tuesday and Thursday from 8 a.m. to 9 a.m. beginning March 24."
    }
    if textBox.text == "Fry's Food Stores" {
      hoursText.text = "Fry’s will dedicate the first shopping hour from 7-8 a.m. on Mondays, Wednesdays and Fridays to senior shoppers, expectant mothers, first responders and those with compromised immune systems."
    }
    if textBox.text == "FoodMaxx" {
      hoursText.text = "We are opening at 6 a.m. to 9 a.m. to serve seniors and those with compromised health – normal operating hours to resume at 9 a.m."
    }
    if textBox.text == "Ralphs" {
      hoursText.text = "Seven days a week, we’re reserving the first half-hour of shopping time, from 7-7:30 a.m., for customers ages 65 and up. Our stores will still be open to customers of all ages from 7:30 a.m.-8 p.m."
    }
    if textBox.text == "Safeway" {
      hoursText.text = "We have also reserved special times for seniors and other vulnerable shoppers who must leave home to obtain their groceries unless otherwise locally mandated. These times are Tuesdays and Thursdays from open time to 9 a.m."
    }
    if textBox.text == "Target" {
      hoursText.text = "The first hour of Wednesday’s Target shopping hours will be available only for “vulnerable guests – including elderly and those with underlying health concerns."
    }
    if textBox.text == "Walgreens" {
      hoursText.text = "Walgreens is offering free shipping for seniors, expanded drive-thru services for seniors and a seniors-only hour in stores from 8-9 a.m. every Tuesday. Senior hours are available to senior citizen customers and patients age 55 and over every Tuesday … from 8 a.m. to 9 a.m."
    }
    if textBox.text == "Walmart" {
      hoursText.text = "Walmart will hold “an hour-long senior shopping event every Tuesday for customers aged 60 and older.” Walmart U.S. stores have adjusted operating hours to 7 a.m. to 8:30 p.m. Stores that open later than 7 a.m. will continue their regular starting hours."
    }
    if textBox.text == "Whole Foods Market" {
      hoursText.text = "All Whole Foods Market stores in the U.S. and Canada will service customers who are 60 and older one hour before opening to the general public, under the new adjusted hours posted on the store’s web page."
    }
  }
   
}
