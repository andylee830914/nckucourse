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
	var isHighLighted:Bool = false
	@IBOutlet weak var schedule: UIView!
	@IBOutlet var weekdayGroup: [UIButton]!
	var dayOfWeek: Int = 4
	var button:UIButton  = UIButton.buttonWithType(UIButtonType.System) as! UIButton
	override func viewDidLoad() {
		super.viewDidLoad()
		let calendar:NSCalendar = NSCalendar.currentCalendar()
		let dateComps:NSDateComponents = calendar.components(.CalendarUnitWeekday , fromDate: NSDate())
		dayOfWeek = (dateComps.weekday + 7 - 2) % 7 + 1
		
		self.nowweek=dayOfWeek
		weekdayGroup[dayOfWeek-1].selected = true
		//print(weekdayGroup)
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func viewWillAppear(animated: Bool) {
		var topboarder : CALayer = CALayer()
		var size = self.schedule.frame.size.width as CGFloat
		topboarder.frame = CGRectMake(0, 0, 2*size , 0.5)
		topboarder.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).CGColor
		self.schedule.layer.addSublayer(topboarder)
		
		button.frame = CGRectMake(0, 0, 100, 44)
		
		self.view.addSubview(button as UIView)
		
		button.removeTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchDown)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	func unhighlightRadioGroup() {
		for button in weekdayGroup {
			button.selected = false
		}
	}
	
	let SegueID = "Daily"
	func settableview(week:Int){
		setValue(week, forKey: "nowweek")
		var dailylist : UITableViewController = self.childViewControllers[0] as! UITableViewController
		dailylist.tableView.reloadData()
		unhighlightRadioGroup()
		dailylist.viewWillAppear(true)
	}
	@IBAction func today(sender: AnyObject) {
		nowweek = dayOfWeek
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			self.weekdayGroup[self.dayOfWeek-1].selected = true
			
		});
		
		
	}
	
	@IBAction func monday(sender: UIButton) {
		nowweek = 1
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			
			sender.selected = true
		});
	}
	@IBAction func tuesday(sender: UIButton) {
		nowweek = 2
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			sender.selected = true
		});
	}
	@IBAction func wednesday(sender: UIButton) {
		nowweek = 3
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			sender.selected = true
		});
	}
	@IBAction func thursday(sender: UIButton) {
		nowweek = 4
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			sender.selected = true
		});
	}
	@IBAction func friday(sender: UIButton) {
		nowweek = 5
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			sender.selected = true
		});
	}
	@IBAction func saturday(sender: UIButton) {
		nowweek = 6
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			sender.selected = true
		});
	}
	@IBAction func sunday(sender: UIButton) {
		nowweek = 7
		settableview(nowweek)
		dispatch_async(dispatch_get_main_queue(), {
			sender.selected = true
		});
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == SegueID {
			//get destination controller
			var destViewController = segue.destinationViewController as! dailyCourse;
			destViewController.weekday=self.nowweek
		}
		
	}
	
	
}

