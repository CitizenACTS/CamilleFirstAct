//
//  MainVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 09/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit
import Firebase




class MainVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var containerTableVC: UIView!
    @IBOutlet weak var containerSavePost: UIView!
    @IBOutlet weak var containerNotifications: UIView!
    
  


  
    



    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        
    
        
        
        // set the current user
        userUid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        DataService.dataservice.REF_BASE.childByAppendingPath("users").childByAppendingPath(userUid).childByAppendingPath("coucouc").setValue("Niketamerde")
        DataService.dataservice.REF_USER_CURRENT.observeSingleEventOfType(.Value) { (snapshot:FDataSnapshot!) in
            let user = snapshot.value as! NSDictionary
            userName = user["displayName"] as! String
            
        }

        switchContainer(0)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MainVC.switchFromNotif), name: "switch", object: nil)
        
        

    }
    
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
        
        if component == 0 {
            return 130
            
        }
        return 40
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return pickerDataSource[0].count
        }
        return 5
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[component][row]
        
    }
    

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemCity = pickerDataSource[0][pickerView.selectedRowInComponent(0)]
        let itemCat1 = pickerDataSource[1][pickerView.selectedRowInComponent(1)]
        let itemCat2 = pickerDataSource[2][pickerView.selectedRowInComponent(2)]
        let itemCat3 = pickerDataSource[3][pickerView.selectedRowInComponent(3)]
        
        postCategory = "\(itemCat1)\(itemCat2)\(itemCat3)"
        postCity = "\(itemCity)"
        

        SendEventCurrentCategory()
        
    }
    
    
    func SendEventCurrentCategory(){
        let postDict:[String: AnyObject] = ["city": postCity, "category": postCategory, "askedPost" : askedPosts]
        print("\(askedPosts) MainVC")
        NSNotificationCenter.defaultCenter().postNotificationName("MainVC", object: nil, userInfo: postDict)
    }

    func switchFromNotif() {
        switchContainer(0)
    }
    
    
    
    // Navigation ContainerView
    
    func switchContainer(identifier: Int) {
        
        if identifier == 0 {
            UIView.animateWithDuration(0.5, animations: {
                self.containerTableVC.alpha = 1
                self.containerSavePost.alpha = 0
                self.containerNotifications.alpha = 0
                
            })
        }
        
        if identifier == 1 {
            UIView.animateWithDuration(0.5, animations: {
                self.containerTableVC.alpha = 0
                self.containerSavePost.alpha = 1
                self.containerNotifications.alpha = 0
            })
            
            
        }
        
        if identifier == 2 {
            UIView.animateWithDuration(0.5, animations: {
                self.containerTableVC.alpha = 0
                self.containerSavePost.alpha = 0
                self.containerNotifications.alpha = 1
            })
        }
    }


    

    //Btn Navigation
    
    @IBAction func goldenView(sender: AnyObject) {
        
        askedPosts = 0
        SendEventCurrentCategory()
        switchContainer(0)
    }
    
    @IBAction func myIdeas(sender: AnyObject) {
        askedPosts = 2
        SendEventCurrentCategory()
        switchContainer(2)
    }
    
    @IBAction func newPostVCBtn(sender: AnyObject) {
        SendEventCurrentCategory()
        switchContainer(1)

    }
    
    @IBAction func seeAllIdeas(sender: AnyObject) {

        askedPosts = 1
        SendEventCurrentCategory()
        switchContainer(0)

    }
    
    @IBAction func seeFavoriteBtn(sender: AnyObject) {
        askedPosts = 3
        SendEventCurrentCategory()
        switchContainer(0)
    }
    
    

    

    
    

}