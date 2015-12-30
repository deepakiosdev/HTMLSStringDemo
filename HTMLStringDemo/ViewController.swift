//
//  ViewController.swift
//  HTMLStringDemo
//
//  Created by Deepak on 30/12/15.
//  Copyright © 2015 Deepak. All rights reserved.
//

import UIKit
//https://www.google.co.in/search?q=how+long+google+anaylitics+activity+updated&ie=utf-8&oe=utf-8&gws_rd=cr&ei=23aDVrKCI8LEmAX9sZigCA
//http://makeapppie.com/2014/10/20/swift-swift-using-attributed-strings-in-swift/
//http://www.scriptscoop.net/t/824a402aa5f7/how-do-i-make-uitextviews-tappable-links-not-have-an-underline.html

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var webView: UIWebView!
    let isShwoWebView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let str = "<head><link rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css\"><style> .btn-primary {color: #FFF;background-color: #D2511E;border-color: #0E0F11;}</style>"
        //let str = "<head><link type=\"text/css\" rel=\"stylesheet\" href=\"http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css\">"

        
       // let str = "<style> .btn-primary { color: #FFF; background-color: #337AB7;  border-color: #2E6DA4; } .btn{ display:inline-block; padding: 6px 12px; margin-bottom: 0px; font-size: 14px; font-weight: 400; line-height: 1.42857; text-align: center; white-space: nowrap; vertical-align: middle; cursor: pointer; -moz-user-select: none; background-image: none; border: 1px solid transparent; border-radius: 4px; } </style>"
        
        let str = "<style> .btn-primary {color: #fff; background-color: #d08400; border: 0 solid transparent; display: inline-block; margin-bottom: 0; font-weight: normal; text-align: center; vertical-align: middle; cursor: pointer; background-image: none; border: 0 solid transparent; white-space: nowrap; font-family: \"VAG Rundschrift D\", \"Helvetica Neue\", Helvetica, Arial, sans-serif; padding: 6px 12px; font-size: 16px; line-height: 1.42857143; border-radius: 4px; -webkit-user-select: none; -moz-user-select: none; -ms-user-select: none; user-select: none; text-decoration: none;} </style>"
      
        //From Local directory
        
        /* var str = ""
        if let bootstrapPath = NSBundle.mainBundle().pathForResource("bootstrap", ofType: "css") {
            //str = "<head><link href=\(bootstrapPath) rel=\"stylesheet\" type=\"html/css\"/> <style> .btn-primary {color: #FFF;background-color: #D2511E;border-color: #0E0F11;}</style>"
            //str = "<head><link rel=\"stylesheet\" href=\"\(bootstrapPath)\"><style> .btn-primary {color: #FFF;background-color: #D2511E;border-color: #0E0F11;}</style>"
            
            str = "<head><link rel=\"stylesheet\" href=\"\(bootstrapPath)\">"
            
        }*/
        
        if let path = NSBundle.mainBundle().pathForResource("DummyData", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                print("json file path:\(path)")
                
                do {
                    let anyObj  = try NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! [String:
                    String]
                    var msg:String = anyObj["Message"]!
                                        // use anyObj here
                  let range = msg.rangeOfString("<head>")
                    msg.replaceRange(range!, with: str)
                    let slashAndQuote = "\\\""
                    print("slashAndQuote:\(slashAndQuote)")

                    let slash = "\""
                    print("slash:\(slash)")
                    
                    let htmlString = msg.stringByReplacingOccurrencesOfString(slashAndQuote, withString: slash, options: .LiteralSearch, range:nil )
                    print("htmlString:\(htmlString)")
                    webView.hidden = !isShwoWebView
                    self.textView.hidden = isShwoWebView
                    if isShwoWebView {
                        //NSURL *mainBundleURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
                    let mainBundleURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
                        webView.loadHTMLString(htmlString, baseURL: mainBundleURL)
                    } else {
                 
                        do {
                            /*let str = try NSAttributedString(data: htmlString.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                            self.textView.attributedText = str*/

                            //var htmlString =  NSURL(fileURLWithPath: path)
                           /* NSURL *htmlString = [[NSBundle mainBundle]  URLForResource: @"string"     withExtension:@"html"];
                            NSAttributedString *stringWithHTMLAttributes = [[NSAttributedString alloc] initWithFileURL:htmlString
                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                            documentAttributes:nil
                            error:nil];
                            textView.attributedText = stringWithHTMLAttributes;*/
                            
                            let htmlFilePath : NSURL =  NSBundle.mainBundle().URLForResource("HtmlString", withExtension: "html")!
                            let stringWithHTMLAttributes = try NSAttributedString(URL: htmlFilePath, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                            self.textView.attributedText = stringWithHTMLAttributes
                        } catch {
                            print(error)
                        }
                    }
                   
                } catch {
                    print("json error: \(error)")
                }
               
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

