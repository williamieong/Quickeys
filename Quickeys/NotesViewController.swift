//
//  NotesViewController.swift
//  Quickies
//
//  Created by Alex Rosenfeld on 12/8/16.
//  Copyright © 2016 Alex Rosenfeld. All rights reserved.
//

import Cocoa

// Notes View Controller class

class NotesViewController: NSViewController {
    // Lets and vars
    
    let GOOGLE_TITLE = "Google"
    let GOOGLE_URL = "https://www.google.com/search?q="

    let WOLFRAM_TITLE = "Wolfram Alpha"
    let WOLFRAM_URL = "https://www.wolframalpha.com/input/?i="
    
    let GOOGLEMAPS_TITLE = "Google Maps"
    let GOOGLEMAPS_URL = "https://www.google.com/maps/search/"

    let YOUTUBE_TITLE = "Youtube"
    let YOUTUBE_URL = "https://www.youtube.com/results?search_query="

    // Outlets
    
    @IBOutlet var inputText: NSTextView!
    @IBOutlet weak var searchTarget: NSPopUpButton!

    // Overrides
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    // Functions
    
    func urlEscapeText(txt: String) -> String{
        return txt.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    
    func searchTextOnWebsite(website: String) {
        // Set our destination url
        var BASE_URL = ""
        switch website {
        case GOOGLE_TITLE:
            BASE_URL = GOOGLE_URL
            break
        case WOLFRAM_TITLE:
            BASE_URL = WOLFRAM_URL
            break
        case GOOGLEMAPS_TITLE:
            BASE_URL = GOOGLEMAPS_URL
            break
        case YOUTUBE_TITLE:
            BASE_URL = YOUTUBE_URL
            break
        default:
            NSLog("Unknown website string: " + website)
            return
        }
        
        let allText = inputText.attributedString().string
        var url_text = ""
        var clean_url_text = ""
        
        if let selectedText = inputText.attributedSubstring(forProposedRange: inputText.selectedRange(), actualRange: nil)?.string {
            url_text = urlEscapeText(txt: selectedText)
        } else {
            url_text = urlEscapeText(txt: allText)
        }
        
        //.urlHostAllowed 
        let customAllowedSet =  NSCharacterSet(charactersIn:"+=\"#%/<>?@\\^`{|}").inverted
        clean_url_text = url_text.addingPercentEncoding(withAllowedCharacters: customAllowedSet)!
        NSLog(clean_url_text)
        
        if let url = URL(string: BASE_URL + clean_url_text), NSWorkspace.shared().open(url) {
            NSLog("browser opened successfully")
        } else {
            NSLog("browser failed to open")
            
        }
        
        
    }
}

// Actions extension

extension NotesViewController {
    // Actions
    
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared().terminate(sender)
    }
    
    @IBAction func searchClicked(_ sender: NSButton) {
        searchTextOnWebsite(website: (searchTarget.selectedItem?.title)!)
    }
}
