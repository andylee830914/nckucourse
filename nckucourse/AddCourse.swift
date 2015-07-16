//
//  AddCourse.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/10.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddCourse: UIViewController, UIPickerViewDelegate, UITextFieldDelegate {

	
	@IBOutlet weak var dep: UITextField!
	@IBOutlet weak var pickerView: UIPickerView! = UIPickerView()
	var Depid = ["C1", "A9", "A4", "L1", "F7"]
	var depobj : NSArray = []
	var selectdep : Int = 0
	var selectsn : Int = 0
	@IBOutlet weak var courseid: UITextField!

	@IBOutlet weak var finish: UILabel!

	@IBOutlet weak var loading: UIActivityIndicatorView!


	
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
		self.finish.text=""
		if component==0{
			selectdep=row
			pickerView.reloadComponent(1)
			if selectsn >= depobj[selectdep]["dep"]!!.count{
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
	func findalert(status : Bool, coursename : String){
		if status {
		let alertController = UIAlertController(title: "新增成功", message:
			"新增課程：\(coursename) 成功！", preferredStyle: UIAlertControllerStyle.Alert)
			alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
			self.presentViewController(alertController, animated: true, completion: nil)
		}else{
			let alertController = UIAlertController(title: "新增失敗", message:
				"\(coursename)", preferredStyle: UIAlertControllerStyle.Alert)
			alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
			self.presentViewController(alertController, animated: true, completion: nil)
		}
		
	}
	
	func findcourse(depno : String,courseid : String,callback: (String, NSArray) -> Void){
		let url = NSURL(string: "http://class-qry.acad.ncku.edu.tw/qry/qry001.php?lang=zh_tw&dept_no="+depno)
		var htmldata : String = ""
		var coursesn : String = ""
		var chinese : String = ""
		var coursedata : String = ""
		var cclass : String = ""
		self.loading.startAnimating()
		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) ->Void in
			
			print("Success")
			if (error != nil) {
				callback("noconnection",[])
				return
			}
			htmldata=NSString(data: data, encoding: NSUTF8StringEncoding)! as String
			//print(matches)
			htmldata = htmldata.stringByReplacingOccurrencesOfString(" style='text-align: center;'", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
			htmldata = htmldata.stringByReplacingOccurrencesOfString(" ", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
			//print(htmldata)
			var getChinesename = NSRegularExpression(pattern: "<TD>(.+?)</TD>\\n<TD>"+depno+"</TD>", options: nil, error: nil)!
			var checkSN = NSRegularExpression(pattern: "<TD>"+depno+"</TD>\\n<TD>"+courseid+"</TD>\\n<TD>([A-Z][A-Z0-9][0-9][0-9][0-9][0-9][0-9])</TD>", options: nil, error: nil)!
			
			//<TD style='text-align: center;' >"+courseid+"</TD><TD style='text-align: center;' >"+depno+"([0-9][0-9][0-9][0-9][0-9])</TD>
			htmldata=htmldata as String
			if let cowMatch = getChinesename.firstMatchInString(htmldata, options: nil,
				range: NSRange(location: 0, length: count(htmldata))){
					chinese = (htmldata as NSString).substringWithRange(cowMatch.rangeAtIndex(1))
					print("\(chinese)")
					//var match=cowMatch as NSTextCheckingResult
					// prints "cow"
			}else{
				print("nothing\n")
				callback("nocourse",[])
				return
			}
			
			if let cowMatch = checkSN.firstMatchInString(htmldata, options: nil,
				range: NSRange(location: 0, length: count(htmldata))){
					coursesn = (htmldata as NSString).substringWithRange(cowMatch.rangeAtIndex(1))
					print("\(coursesn)")
					//var match=cowMatch as NSTextCheckingResult
					// prints "cow"
			}else{
				print("nothing\n")
				callback("nocourse",[])
				return
			}
			var getcclass = NSRegularExpression(pattern: "<TD>"+depno+"</TD>\\n<TD>"+courseid+"</TD>\\n<TD>"+coursesn+"</TD>\\n<TD>([A-Z0-9]{0,2})</TD>", options: nil, error: nil)!
			if let cowMatch = getcclass.firstMatchInString(htmldata, options: nil,
				range: NSRange(location: 0, length: count(htmldata))){
					cclass = (htmldata as NSString).substringWithRange(cowMatch.rangeAtIndex(1))
					print("class:\(cclass)\n")
					//var match=cowMatch as NSTextCheckingResult
					// prints "cow"
			}
			var checkDATA = NSRegularExpression(pattern: "cono="+coursesn+"\">([\\s\\S]+)="+coursesn+"", options: nil, error: nil)!
			//<TD style='text-align: center;' >"+courseid+"</TD><TD style='text-align: center;' >"+depno+"([0-9][0-9][0-9][0-9][0-9])</TD>
			if let cowMatch = checkDATA.firstMatchInString(htmldata, options: nil,
				range: NSRange(location: 0, length: count(htmldata))){
					coursedata = "cname"+(htmldata as NSString).substringWithRange(cowMatch.rangeAtIndex(1))
					print("\(coursedata)")
					//var match=cowMatch as NSTextCheckingResult
					// prints "cow"
			}else{
				//self.findalert(false, coursename: "")
				print("nothing\n")

				callback("nocourse",[])
				return
			}
			
			var parseDATA = NSRegularExpression(pattern: "cname(.+)</a></TD>\\n<TD>(.+)</TD>\\n<TD>([0-9])</TD><TD>(.+)</TD>\\n<TD>(?:[0-9]{1,3})</TD>\\n<TD>(?:[0-9]{1,3})</TD>\\n<TD>(.+)</TD>\\n<TD><aclass='room'(?:.+)>(.*)</a></TD>\\n<TD><atarget=\"moodle\"href=\"moodle.php\\?syear=(.+)&sem=(.+)&co_no(?:[\\s\\S]*)", options: nil, error: nil)!
			var matches = parseDATA.stringByReplacingMatchesInString(coursedata, options: nil, range: NSRange(location: 0, length: count(coursedata)), withTemplate: "$1,$2,$3,$4,$5,$6,$7,$8")
			matches = depno+","+chinese+","+courseid+","+coursesn+"," + matches
			matches = matches+","+cclass
			let matchesArr = matches.componentsSeparatedByString(",")
			//print(matches)
			callback("Success",matchesArr)
			return
		}
		
		task.resume()
		
		return
		
	}
	func checkhandle(status: String ,respond : NSArray)->(Bool,String){
		dispatch_async(dispatch_get_main_queue(),{
			self.loading.stopAnimating()
		});
		//FOR ADD DATA
		let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
		let entityDescription = NSEntityDescription.entityForName("Course",inManagedObjectContext: managedObjectContext!)
		
		
		
		
		
		if status=="Success" {
			//FOR SEARCH DATA
			let fetchRequest = NSFetchRequest(entityName: "Course")
			let cidsearch = NSPredicate(format: "cid == %@",respond[3] as! String)
			
			fetchRequest.predicate=cidsearch
			print(respond)
			
			if let fetchedResults = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil) as! [NSManagedObject]?{
				for var n = 0; n < fetchedResults.count; n++ {
					println(fetchedResults[n].valueForKey("cid") as! String)
				}
				print(fetchedResults.count)
				
				if fetchedResults.count==0 {
					let course = NSManagedObject(entity: entityDescription!,insertIntoManagedObjectContext: managedObjectContext)
					course.setValue(respond[0] as! String, forKey: "dep")
					course.setValue(respond[1] as! String, forKey: "depname")
					course.setValue(respond[2] as! String, forKey: "csn")
					course.setValue(respond[3] as! String, forKey: "cid")
					course.setValue(respond[4] as! String, forKey: "name")
					course.setValue(respond[5] as! String, forKey: "type")
					course.setValue(respond[6] as! String, forKey: "credit")
					course.setValue(respond[7] as! String, forKey: "teacher")
					course.setValue(respond[8] as! String, forKey: "time")
					course.setValue(respond[9] as! String, forKey: "place")
					course.setValue(respond[10] as! String, forKey: "syear")
					course.setValue(respond[11] as! String, forKey: "sem")
					course.setValue(respond[12] as! String, forKey: "cclass")
					
					var error: NSError?
					if !managedObjectContext!.save(&error) {
						println("Could not save \(error), \(error?.userInfo)")
					}
					dispatch_async(dispatch_get_main_queue(),{
						var cour=respond[4] as! String
						self.finish.text="  新增課程："+cour+" 成功！"
						self.finish.textAlignment = NSTextAlignment.Center;
					});
					return (true,respond[4] as! String)
				}else{
					dispatch_async(dispatch_get_main_queue(),{
						var cour=respond[4] as! String
						self.finish.text="  新增課程："+cour+" 已存在！"
						self.finish.textAlignment = NSTextAlignment.Center;
					});
					return (false,respond[4] as! String)
				}
				
				
				
			}
			//print(fetchRequest)

			
			
			
			
		}else if status=="nocourse"{
			print(status)
			dispatch_async(dispatch_get_main_queue(),{
				self.finish.text="  查無課程！"
				self.finish.textAlignment = NSTextAlignment.Center;
			});
			return (false,"查無課程！")
		}else if status=="noconnection"{
			print(status)
			dispatch_async(dispatch_get_main_queue(),{
				self.finish.text="  請檢查網路連線！"
				self.finish.textAlignment = NSTextAlignment.Center;
			});
			return (false,"請檢查網路連線！")
		}
		
		return (false,"")
	}
	
	@IBAction func addCourse(sender: AnyObject) {
		findcourse( dep.text,courseid: courseid.text){
			(status, data) -> Void in
			print(self.checkhandle(status, respond: data))
			
			
		}
		//print(course)
		//findalert(status,coursename: course[0] as! String)

	}

	
}
