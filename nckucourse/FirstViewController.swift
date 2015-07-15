//
//  FirstViewController.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/10.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
	
	var nowweek:Int = 4
	@IBOutlet weak var schedule: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let calendar:NSCalendar = NSCalendar.currentCalendar()
		let dateComps:NSDateComponents = calendar.components(.CalendarUnitWeekday , fromDate: NSDate())
		let dayOfWeek = (dateComps.weekday + 7 - 2) % 7 + 1
		
		self.nowweek=dayOfWeek
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func viewWillAppear(animated: Bool) {
		var topboarder : CALayer = CALayer()
		var size = self.schedule.frame.size.width as CGFloat
		topboarder.frame = CGRectMake(0, 0, 2*size , 0.5)
		topboarder.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).CGColor
		self.schedule.layer.addSublayer(topboarder)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
	let SegueID = "Daily"
	func settableview(week:Int){
		setValue(week, forKey: "nowweek")
		var dailylist : UITableViewController = self.childViewControllers[0] as! UITableViewController
		dailylist.tableView.reloadData()
		dailylist.viewWillAppear(true)
	}
	
	@IBAction func monday(sender: AnyObject) {
		nowweek = 1
		settableview(nowweek)
	}
	@IBAction func tuesday(sender: AnyObject) {
		nowweek = 2
		settableview(nowweek)
	}
	@IBAction func wednesday(sender: AnyObject) {
		nowweek = 3
		settableview(nowweek)
	}
	@IBAction func thursday(sender: AnyObject) {
		nowweek = 4
		settableview(nowweek)
	}
	@IBAction func friday(sender: AnyObject) {
		nowweek = 5
		settableview(nowweek)
	}
	@IBAction func saturday(sender: AnyObject) {
		nowweek = 6
		settableview(nowweek)
	}
	@IBAction func sunday(sender: AnyObject) {
		nowweek = 7
		settableview(nowweek)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == SegueID {
			//get destination controller
			var destViewController = segue.destinationViewController as! dailyCourse;
			destViewController.weekday=self.nowweek
		}
		
	}
	
	
}

