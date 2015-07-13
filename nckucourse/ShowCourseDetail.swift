//
//  ShowCourseDetail.swift
//  nckucourse
//
//  Created by Lee Yu Hsun on 2015/7/13.
//  Copyright (c) 2015年 Lee Yu Hsun. All rights reserved.
//

import UIKit

class ShowCourseDetail: UIViewController {
	var receiveData: String!
	var data: Course!
	@IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = data.name
		println(receiveData)
		print(data)
		var courseid = data.cid
		var cclass = data.cclass
		let url = NSURL(string: "http://class-qry.acad.ncku.edu.tw/syllabus/online_display.php?syear=0104&sem=1&co_no="+courseid+"&class_code="+cclass)
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
