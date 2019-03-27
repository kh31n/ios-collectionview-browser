//
//  ViewController.swift
//  ios_collectionview_browser
//
//  Created by 川合弘敏 on 2017/07/25.
//  Copyright © 2017年 川合弘敏. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    let searchEngineUrl = "https://www.google.co.jp/search?q="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.searchBar.delegate = self
        self.webView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let originalUrl = searchEngineUrl + searchBar.text!
        let reqUrl = URL(string: originalUrl)
        let req = URLRequest(url: reqUrl!)
        self.webView.loadRequest(req)
    }
    
    @IBAction func tappedButton(_ sender: Any) {
        performSegue(withIdentifier: "switchCollectionView", sender: showButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIButton {
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.currentWebView = self.webView
        }
    }
}

