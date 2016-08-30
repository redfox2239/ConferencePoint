//
//  PersonView.swift
//  ConferencePoint
//
//  Created by 原田　礼朗 on 2016/08/29.
//  Copyright © 2016年 reo harada. All rights reserved.
//

import UIKit

class PersonView: UIView {

    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var rankingView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var point: Int = 0
    var timer: NSTimer? = nil
    var time: Int = 0
    var selected: Bool = false
    
    override func awakeFromNib() {
        pointLabel.text = ""
        timeLabel.text = ""
        rankingView.hidden = true
    }
    
    @IBAction func tapView(sender: AnyObject) {
        if !selected {
            return
        }
        if timer == nil {
            NSNotificationCenter.defaultCenter().postNotificationName("tapView", object: nil)
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "addTime", userInfo: nil, repeats: true)
            backgroundView.backgroundColor = UIColor(red: 230/255, green: 237/255, blue: 255/255, alpha: 0.5)
            return
        }
        UIView.animateWithDuration(0.1, animations: {
            self.backgroundView.transform = CGAffineTransformMakeScale(2.0, 2.0)
            }) { (animate) in
                self.backgroundView.transform = CGAffineTransformIdentity
        }
        point += 1
        pointLabel.text = "\(point)pt"
    }
    
    func addTime() {
        time += 1
        timeLabel.text = "\(time)秒"
    }
    
    func resetTimer() {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        backgroundView.backgroundColor = UIColor.whiteColor()
    }
}
