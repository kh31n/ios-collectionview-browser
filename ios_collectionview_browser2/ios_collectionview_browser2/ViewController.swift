//
//  ViewController.swift
//  ios_collectionview_browser2
//
//  Created by 川合弘敏 on 2017/07/25.
//  Copyright © 2017年 川合弘敏. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    let searchEngineUrl = "https://www.google.co.jp/search?q="
    var originalUrl = [String]()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.delegate = self
        self.searchBar.delegate = self
        self.showButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedButton(_ sender: Any) {
        let flowLayout = UICollectionViewFlowLayout()
        let margin: CGFloat = 3.0
        flowLayout.itemSize = CGSize(width: 100.0, height: 100.0)
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        self.collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }

    @IBAction func tappedAddButton(_ sender: Any) {
        self.showButton.isEnabled = true
        count += 1
        self.showButton.setTitle(count.description, for: .normal)
        self.collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        originalUrl.append(searchEngineUrl + searchBar.text!)
        self.showButton.setTitle(count.description, for: .normal)
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "originalCell", for: indexPath) as! CollectionViewCell
        if originalUrl.isEmpty == false && originalUrl.count == count {
            let reqUrl = URL(string: originalUrl[indexPath.row])
            let req = URLRequest(url: reqUrl!)
            cell.webView.loadRequest(req)
        }
        return cell
    }
}

