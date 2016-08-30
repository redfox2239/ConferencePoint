//
//  InputMemberViewController.swift
//  ConferencePoint
//
//  Created by 原田　礼朗 on 2016/08/29.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class InputMemberViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    // データを受け取る部品
    var numberOfPeople: String!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var memberTextField: UITextField!
    @IBOutlet weak var memberTableView: UITableView!
    var memberData: [String] = []
    @IBOutlet weak var completeButton: UIBarButtonItem!
    @IBOutlet weak var marginBottomMemberRableView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        numberOfPeopleLabel.text = "\(numberOfPeople)人の名前を入れてね"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showKeyboard:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "hideKeyboard:", name: UIKeyboardWillHideNotification, object: nil)
        memberTextField.becomeFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func showKeyboard(notification: NSNotification) {
        let keyboard = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        marginBottomMemberRableView.constant = keyboard.size.height
    }
    
    func hideKeyboard(notification: NSNotification) {
        marginBottomMemberRableView.constant = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = memberData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if memberData.count == Int(numberOfPeople) {
            memberTextField.enabled = true
            completeButton.enabled = false
            memberTextField.becomeFirstResponder()
        }
        memberData.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text != "" {
            memberData.append(textField.text!)
            textField.text = ""
            memberTableView.reloadData()
            if memberData.count == Int(numberOfPeople) {
                completeButton.enabled = true
                textField.resignFirstResponder()
                textField.enabled = false
            }
        }
        return true
    }

    @IBAction func tapCompeleteButton(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("席順画面") as! SeatingArrangementViewController
        vc.memberData = memberData
        showViewController(vc, sender: nil)
    }
    
}
