//
//  MainVC.swift
//  Camille
//
//  Created by Pierre De Pingon on 09/05/2016.
//  Copyright © 2016 Pierre De Pingon. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    
    @IBOutlet weak var contain: UIView!
    @IBOutlet weak var questionLbl: UILabel!
    
    var containerView: ContainerViewController?
    
    var feedVC = FeedVC()
    var seePost = SeePost()
    
    var arrayCategoryQuest = ["", "", ""]
    var arrayCategoryPath = ["", "", ""]
    var currentCount = 0
    
    var postCategory1 = ""
    var postCategory2 = ""
    var postCategory3 = ""
    
    var postQuestion = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        questionLbl.text = "pose une question"
        
        
        
        

    }
    
    
    func currentCountUpdate(identifier: Int) {
        
        currentCount += 1
        if currentCount == 3 {
            findQuestion(identifier)
            let dictCategory = ["question": postQuestion, "cat1": postCategory1, "cat2": postCategory2, "cat3": postCategory3]
            NSNotificationCenter.defaultCenter().postNotificationName("saveQuestionEnabled", object: self, userInfo: dictCategory)
        }
        if currentCount >= 4 {
            currentCount = 0
            arrayCategoryQuest = ["", "", ""]
            arrayCategoryPath = ["", "", ""]
            questionLbl.text = "pose une question"

        } else {
            findQuestion(identifier)
            upGradeQuest()
        }
    }
    
    
    func upGradeQuest(){
        questionLbl.text = "\(arrayCategoryQuest[0])\(arrayCategoryQuest[1])\(arrayCategoryQuest[2])"
        postQuestion = "\(arrayCategoryQuest[0])\(arrayCategoryQuest[1])\(arrayCategoryQuest[2])"
     
    }
    
    
    func findQuestion(identifier: Int){
        
        arrayCategoryPath[currentCount-1] = ArrayCategory[identifier]
        arrayCategoryQuest[currentCount-1] = DictCategory[currentCount]![identifier]
        postCategory1 = arrayCategoryPath[0]
        postCategory2 = arrayCategoryPath[0] + arrayCategoryPath[1]
        postCategory3 = arrayCategoryPath[0] + arrayCategoryPath[1] + arrayCategoryPath[2]
        
        
        

    }
    
    
    // Navigation ContainerView
    


    
    

    //Btn Navigation
    
    @IBAction func profilBtn(sender: AnyObject) {
    }
    
    @IBAction func createNewIdea(sender: AnyObject) {
        containerView!.segueIdentifierReceivedFromParent("buttonTwo")

        
    }
    
    @IBAction func seeAllIdeas(sender: AnyObject) {
        containerView!.segueIdentifierReceivedFromParent("buttonOne")
       
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "container"{
            
            containerView = segue.destinationViewController as? ContainerViewController
            
            
        }
    }
    
    
    //Btn Category

    @IBAction func creerBtn(sender: AnyObject) {
        currentCountUpdate(0)
        
    }
    
    @IBAction func produireBtn(sender:AnyObject) {
        
    }

}
