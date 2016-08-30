//
//  ViewController.swift
//  ConferencePoint
//
//  Created by 原田　礼朗 on 2016/08/29.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var numberOfPeopleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapInputButton(sender: AnyObject) {
        if Int(self.numberOfPeopleTextField.text!) < 9 {
            // 次の画面に移動する
            // あたしく追加した画面、as!で正体を保証してあげる必要がある
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("メンバー入力画面") as! InputMemberViewController
            // 数字を渡す
            next.numberOfPeople = self.numberOfPeopleTextField.text
            // 次の画面に移動する
            showViewController(next, sender: nil)
        }
        else {
            let alert = UIAlertController(title: "会議に上限人数は、8人までです。", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            let button = UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(button)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    

}

