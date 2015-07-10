//
//  AddCourse.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/10.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit
import Foundation

class AddCourse: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

	
	@IBOutlet weak var dep: UITextField!
	@IBOutlet weak var pickerView: UIPickerView! = UIPickerView()
	var Depid = ["C1", "A9", "A4", "L1", "F7"]
	var depobj : NSArray = []
	var selectdep : Int = 0
	var selectsn : Int = 0
	
	
	@IBOutlet weak var courseid: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.pickerView.delegate = self
		//pickerView.hidden = true
		self.dep.delegate = self
		dep.inputView = pickerView
		self.courseid.delegate = self
		let deppath = NSBundle.mainBundle().pathForResource("dep", ofType: "json")
		let jsonData = NSData(contentsOfFile:deppath!)
		let jsonobj:NSArray = (NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions.MutableContainers , error: nil) as? NSArray)!
		depobj = jsonobj
		
		//print(jsonobj)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
	{
		return 2;
	}
	
	func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int
	{
		if component==0{
			return depobj.count
		}else if component==1{
			return depobj[selectdep]["dep"]!!.count
		}else{
			return 0
		}
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
	{
		//print(depobj[0]["name"])
		if component==0{
			return (depobj[row]["name"] as? String)!
		}else{
			var depid: AnyObject = depobj[selectdep]["dep"]!!
			return  (depid[row]["name"] as? String)!
		}
		
	}
	
	func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		if component==0{
			selectdep=row
			pickerView.reloadComponent(1)
			if selectsn > depobj[selectdep]["dep"]!!.count{
				selectsn=depobj[selectdep]["dep"]!!.count-1
			}
			var depid: AnyObject = depobj[selectdep]["dep"]!!
			dep.text = (depid[selectsn]["id"] as? String)!

		}else{
			selectsn=row
			var depid: AnyObject = depobj[selectdep]["dep"]!!
			dep.text = (depid[selectsn]["id"] as? String)!
		}
		
		
		//pickerView.hidden = false
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
	func findcourse(depno : String)->Bool{
		let url = NSURL(string: "http://class-qry.acad.ncku.edu.tw/qry/qry001.php?dept_no="+depno)
		
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
			println(NSString(data: data, encoding: NSUTF8StringEncoding))
		}
		
		task.resume()
		return true
	}
	@IBAction func addCourse(sender: AnyObject) {
		findcourse( dep.text)
	}

	
}
