//
//  MeetingViewController.swift
//  ConferencePoint
//
//  Created by 原田　礼朗 on 2016/08/29.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class MeetingViewController: UIViewController {
    
    var memberView: [PersonView] = []
    var maxPoint: Int! = 0
    var isEndMeeting: Bool = false
    @IBOutlet weak var endMeetingButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetAllView", name: "tapView", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        memberView.forEach { (personView) in
            personView.selected = true
            view.addSubview(personView)
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func resetAllView() {
        memberView.forEach { (personView) in
            personView.resetTimer()
        }
    }
    
    var touchPoint: CGPoint!
    var selectViewPoint: CGPoint!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isEndMeeting {
            touchPoint = touches.first?.locationInView(view)
            if let selectView = touches.first?.view?.superview as? PersonView {
                selectViewPoint = selectView.frame.origin
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isEndMeeting {
            let movePoint = touches.first?.locationInView(view)
            if let selectView = touches.first?.view?.superview as? PersonView {
                selectView.frame.origin.x = selectViewPoint.x + (movePoint!.x - touchPoint.x)
                selectView.frame.origin.y = selectViewPoint.y + (movePoint!.y - touchPoint.y)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapEndMeetingButton(sender: AnyObject) {
        if isEndMeeting {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        endMeetingButton.title = "最初に戻る"
        isEndMeeting = true
        memberView.forEach { (personView) in
            var position = 1
            let myPoint = personView.point * personView.time
            memberView.forEach { (view) in
                if personView != view {
                    let otherPoint = view.point * view.time
                    if myPoint < otherPoint {
                        position += 1
                    }
                }
            }
            personView.rankingView.hidden = false
            personView.rankingLabel.text = "\(position)位"
            personView.selected = false
            personView.resetTimer()
        }
    }

}
