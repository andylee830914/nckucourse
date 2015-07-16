//
//  ShowCourseDetail.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/13.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit

class ShowCourseDetail: UIViewController {
	var data: Course?
	var page: String=""
	@IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//print(data)
		
		var url : NSURL?
		switch page {
		case "syllabus" :
			self.title = data!.name
			var syear = data!.syear
			var sem = data!.sem
			var courseid = data!.cid
			var cclass = data!.cclass
			url = NSURL(string: "http://class-qry.acad.ncku.edu.tw/syllabus/online_display.php?syear="+syear+"&sem="+sem+"&co_no="+courseid+"&class_code="+cclass)
			break
			
		case "coursesearch" :
			self.title = "國立成功大學課程查詢系統"
			url = NSURL(string: "http://course-query.acad.ncku.edu.tw/qry/index.php?lang=zh_tw")
			break
			
		case "homepage" :
			self.title = "國立成功大學"
			url = NSURL(string: "http://www.ncku.edu.tw")
			break
			
		case "incku" :
			self.title = "成功入口"
			url = NSURL(string: "http://i.ncku.edu.tw")
			break
			
		default :
			self.title = "國立成功大學"
			url = NSURL(string: "http://www.ncku.edu.tw")
			break
			
			
			
		}
		
		let requestObj = NSURLRequest(URL: url!)
		webview.loadRequest(requestObj)
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

}
