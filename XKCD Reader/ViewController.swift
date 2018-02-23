//
//  ViewController.swift
//  XKCD Reader
//
//  Created by David Taylor on 2/15/18.
//  Copyright © 2018 Hyper Elephant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBAction func nextPressed(_ sender: Any) {
        if(currentNum > 0){
            currentNum -= 1
            NetworkHelper.get(urlSting: Comic.URLString(num: currentNum), completionBlock: handleComicData)
        }
    }
    @IBAction func previousPressed(_ sender: Any) {
        if(currentNum < maxNum){
            currentNum += 1
            NetworkHelper.get(urlSting: Comic.URLString(num: currentNum), completionBlock: handleComicData)
        }
    }
    @IBAction func longPressed(_ sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.began
        {
            let alertController = UIAlertController(title: nil, message:
                currentComic?.alt, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    var currentComic: Comic?
    var maxNum = 0;
    var currentNum = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkHelper.get(urlSting: Comic.DefaultURL, completionBlock: handleFirst)
    }
    
    func handleFirst(data:Data){
        handleComicData(data: data)
        if let comic = currentComic {
            maxNum = comic.num
            currentNum = comic.num
        }
    }
    
    func handleComicData(data: Data){
        currentComic = Comic.ComicFromJSON(data: data)
        if let loadedComic = currentComic {
            getComicImage(comic: loadedComic)
        }
    }
    
    func getComicImage(comic: Comic){
        NetworkHelper.get(urlSting: comic.img, completionBlock: { (data) in
            guard let image = UIImage(data: data) else {
                return;
            }
            DispatchQueue.main.async {
                self.comicImage.image = image;
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

