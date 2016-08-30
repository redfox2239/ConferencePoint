//
//  SeatingArrangementViewController.swift
//  ConferencePoint
//
//  Created by 原田　礼朗 on 2016/08/30.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class SeatingArrangementViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    var memberData: [String] = []
    var memberView: [PersonView] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        memberData.enumerate().forEach { (index,name) in
            let xib = UINib(nibName: "PersonView", bundle: nil)
            let personView = xib.instantiateWithOwner(self, options: nil)[0] as! PersonView
            personView.nameLabel.text = name
            if index%2 == 0 {
                personView.frame.origin.x = 10
            }
            else {
                personView.frame.origin.x = view.frame.size.width - personView.frame.size.width - 10
            }
            if index%2 == 0 {
                personView.frame.origin.y = infoLabel.frame.origin.y + infoLabel.frame.size.height + 5 + (personView.frame.size.height + 10) * CGFloat(index/2)
            }
            else {
                personView.frame.origin.y = infoLabel.frame.origin.y + infoLabel.frame.size.height + 5 + (personView.frame.size.height + 10) * CGFloat((index-1)/2)
            }
            memberView.append(personView)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        memberView.forEach { (personView) in
            personView.selected = false
            personView.resetTimer()
            personView.rankingView.hidden = true
            view.addSubview(personView)
        }
    }
    
    var touchPoint: CGPoint!
    var selectViewPoint: CGPoint!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPoint = touches.first?.locationInView(view)
        if let selectView = touches.first?.view as? PersonView {
            selectViewPoint = selectView.frame.origin
        }
        if let selectView = touches.first?.view?.superview as? PersonView {
            selectViewPoint = selectView.frame.origin
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let movePoint = touches.first?.locationInView(view)
        if let selectView = touches.first?.view as? PersonView {
            selectView.frame.origin.x = selectViewPoint.x + (movePoint!.x - touchPoint.x)
            selectView.frame.origin.y = selectViewPoint.y + (movePoint!.y - touchPoint.y)
        }
        if let selectView = touches.first?.view?.superview as? PersonView {
            selectView.frame.origin.x = selectViewPoint.x + (movePoint!.x - touchPoint.x)
            selectView.frame.origin.y = selectViewPoint.y + (movePoint!.y - touchPoint.y)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapStartMeetingButton(sender: AnyObject) {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("会議画面") as! MeetingViewController
        vc.memberView = memberView
        showViewController(vc, sender: nil)
    }
}
