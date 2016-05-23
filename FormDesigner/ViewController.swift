//
//  ViewController.swift
//  FormDesigner
//
//  Created by alexfu on 5/21/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit



class ViewController: UITableViewController  {

	@IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var FormTitle: UITextField!

 //For custom Field
    
    @IBOutlet weak var FieldName: UITextField!
    @IBOutlet weak var TypeSegment: UISegmentedControl!
    @IBOutlet weak var TextSegment: UISegmentedControl!
    @IBOutlet weak var NumberSegment: UISegmentedControl!
    @IBOutlet weak var ControlSegment: UISegmentedControl!
   

	override func viewDidLoad() {
		super.viewDidLoad()
       
        setupTagList()
        tableView.keyboardDismissMode = .OnDrag
        FieldName.delegate = self
        FormTitle.delegate = self
        
        
    }
    func setupTagList() {
        
       tagListView.tagBackgroundColor = UIColor(red:0.412,  green:0.635,  blue:0.918, alpha:1)
        tagListView.cornerRadius = 12
        tagListView.paddingY = 6
        tagListView.paddingX = 12
        tagListView.marginX = 10
        tagListView.marginY = 7
        tagListView.enableRemoveButton = true
        tagListView.removeButtonIconSize = 7
        tagListView.removeIconLineWidth = 2
        tagListView.removeIconLineColor = UIColor.yellowColor()
        tagListView.borderWidth = 2
      //   tagListView.selectedBorderColor = UIColor(red:1,  green:0.776,  blue:0, alpha:1)
      //  tagListView.tagSelectedBackgroundColor = UIColor.redColor()
        tagListView.borderRadius = 3
        tagListView.shadowColor = UIColor.darkGrayColor()
        tagListView.shadowOffset = CGSize(width: 1,height: 1)
         tagListView.delegate = self
        
        
    }



	@IBAction func ButtonTap(button: UIButton) {
		//tagListView.addTag(button.titleLabel!.text!, )
        let type =  FormRowType(rawValue:button.tag)
        
        tagListView.addTag(button.titleLabel!.text!, cellType: type!)
		
	}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "form") {
            let formVC:ExampleViewController = segue.destinationViewController as! ExampleViewController
            var cells:[Cell]=[]
            for tagview in tagListView.tagViews {
                var cell = Cell(type:.Unknown,tag:"")
                cell.type = tagview.cellType
                cell.tag = (tagview.titleLabel?.text)!
               cells.append(cell)
                
            }
            formVC.title = FormTitle.text
            formVC.cells = cells
        }
    }
    
  
    @IBAction func AddCustomField(sender: AnyObject) {
        var type:FormRowType = .Text
        
        switch (TypeSegment.selectedSegmentIndex) {
        case 0:
            switch(TextSegment.selectedSegmentIndex) {
            case 0: type = .Name
            case 1: type = .Text
            case 2: type = .Email
            case 3: type = .MultilineText
            default: break
                
            }
        case 1:
            switch(NumberSegment.selectedSegmentIndex) {
            case 0: type = .Number
            case 1: type = .Decimal
            case 2: type = .Phone
            default: break
            }
            
        case 2:
            switch(ControlSegment.selectedSegmentIndex) {
            case 0: type = .BooleanCheck
            case 1: type = .BooleanSwitch
            case 2: type = .Slider
            case 3: type = .Stepper
            case 4: type = .Picker
            default: break
            }
        case 3: type = .Date
        case 4: type = .Time
        default: break
        }
        let field = FieldName.text!
        if field.characters.count != 0 {
            tagListView.addTag(field, cellType: type)
            FieldName.text = ""
        } else {
            
            showAlert()
        }
        
                //Clear
    }
    
     func showAlert() {
        let alertController = UIAlertController(title: "", message: "Field Name could not be empty", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }

    
    @IBAction func FiledTypeChange(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            TextSegment.hidden = false
            NumberSegment.hidden = true
            ControlSegment.hidden = true
        case 1:
            TextSegment.hidden = true
            NumberSegment.hidden = false
            ControlSegment.hidden = true
        case 2:
            TextSegment.hidden = true
            NumberSegment.hidden = true
            ControlSegment.hidden = false
        case 3,4:
        
            TextSegment.hidden = true
            NumberSegment.hidden = true
            ControlSegment.hidden = true
        default:
            break
        }
        
        
        
        
        
    }
   
}

extension ViewController:TagListViewDelegate {
    
    // MARK: TagListViewDelegate
    func tagPressed(title: String, tagView: TagView, sender: TagListView) {
       // print("Tag pressed: \(title), \(sender)")
        tagView.selected = !tagView.selected
    }
    
    func tagRemoveButtonPressed(title: String, tagView: TagView, sender: TagListView) {
      //  print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

extension ViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        FormTitle.resignFirstResponder()
        FieldName.resignFirstResponder()
        return true
        
    }
   
    
   
    
}

