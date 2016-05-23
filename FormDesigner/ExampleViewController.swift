//
//  FormViewController.swift
//  FormDesigner
//
//  Created by alexfu on 5/21/16.
//  Copyright © 2016 alexfu. All rights reserved.
//

import UIKit





public struct Cell {
    var type:FormRowType
    var tag:String
}


public class ExampleViewController: FormViewController  {
    public var cells:[Cell]!
   

  
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        
        for cell in cells {
            
            let row =  createCell(cell)
            section1.addRow(row)
            
        }
        form.sections = [section1]
    }
    
    
     func createCell(cell:Cell) -> FormRowDescriptor{
        
        var row = FormRowDescriptor(tag: cell.tag, rowType: cell.type, title: cell.tag)
        
        switch(cell.type) {
        case .Unknown:
                print("error")
   //     case Label:
        case .Name:
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
        case .Text:
           
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        case .URL:
           
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. gethooksapp.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
        case .Number ,.Decimal:
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
            
        case .Phone:
            
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "e.g. 0034666777999", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
        
  
        case .Email:
            
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "john@gmail.com", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
          
   //     case Twitter
   //     case ASCIICapable
        case .Password:
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["textField.placeholder" : "Enter password", "textField.textAlignment" : NSTextAlignment.Right.rawValue]
  /*
        case .Button:
        case .BooleanSwitch:
        case .BooleanCheck:
    */
        case .SegmentedControl:
            row.configuration[FormRowDescriptor.Configuration.Options] = [0, 1, 2, 3]
            row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                switch( value ) {
                case 0:
                    return "None"
                case 1:
                    return "!"
                case 2:
                    return "!!"
                case 3:
                    return "!!!"
                default:
                    return ""
                }
                } as TitleFormatterClosure
            
            row.configuration[FormRowDescriptor.Configuration.CellConfiguration] = ["titleLabel.font" : UIFont.boldSystemFontOfSize(30.0), "segmentedControl.tintColor" : UIColor.redColor()]
            
        case .Picker:
            if (cell.tag == "Gender") {
                row.configuration[FormRowDescriptor.Configuration.Options] = ["F", "M", "U"]
                row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                    switch( value ) {
                    case "F":
                        return "Female"
                    case "M":
                        return "Male"
                    case "U":
                        return "I'd rather not to say"
                    default:
                        return ""
                    }
                    } as TitleFormatterClosure
                
                row.value = "M"
            }
            
            if (cell.tag == "Size") {
                row.configuration[FormRowDescriptor.Configuration.Options] = ["XS","S", "M", "L", "XL"]
                row.value = "M"
            }
            
            

            
        case .Date:
            break
           
            
   //     case Time:
            
   //     case DateAndTime:
            
      //  case Stepper:
            
      //  case Slider:
            
        case .MultipleSelector:
           
            row.configuration[FormRowDescriptor.Configuration.Options] = [0, 1, 2, 3, 4]
            row.configuration[FormRowDescriptor.Configuration.AllowsMultipleSelection] = true
            row.configuration[FormRowDescriptor.Configuration.TitleFormatterClosure] = { value in
                switch( value ) {
                case 0:
                    return "Restaurant"
                case 1:
                    return "Pub"
                case 2:
                    return "Shop"
                case 3:
                    return "Hotel"
                case 4:
                    return "Camping"
                default:
                    return ""
                }
                } as TitleFormatterClosure
            
    //   case .MultilineText:

           
            
        default:
            break;
        }
    
        return row
        
        
    }
    
    
     private func loadForm() {
       
        let form = FormDescriptor()
       
        self.form = form
    }
   
}
