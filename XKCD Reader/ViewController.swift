//
//  ViewController.swift
//  XKCD Reader
//
//  Created by David Taylor on 2/15/18.
//  Copyright © 2018 Hyper Elephant. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoBackground: UIImageView!
    @IBOutlet weak var closeInfoButton: UIButton!
    
    @IBAction func infoPressed(_ sender: Any) {
        infoView.isHidden = false
        infoButton.isHidden = true
        
    }
    @IBAction func closeButtonPressed(_ sender: Any) {
        infoView.isHidden = true
        infoButton.isHidden = false
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if(currentNum > 0){
            currentNum -= 1
            
            NetworkHelper.get(urlSting: Comic.URLString(num: currentNum), completionBlock: handleComicData)
            if(currentNum == 1){
                nextButton.isHidden = true
            } else if (currentNum < maxNum){
                previousButton.isHidden = false
            }
        }
    }
    @IBAction func previousPressed(_ sender: Any) {
        if(currentNum < maxNum){
            currentNum += 1
            NetworkHelper.get(urlSting: Comic.URLString(num: currentNum), completionBlock: handleComicData)
            if currentNum == maxNum {
                previousButton.isHidden = true
            }
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
    var maxNum = 0
    var currentNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        nextButton.setImage(StyleKit.imageOfNextButton, for: .normal)
        previousButton.setImage(StyleKit.imageOfPreviousButton, for: .normal)
        infoButton.setImage(StyleKit.imageOfInfoButton, for: .normal)
        previousButton.isHidden = true;
        titleLabel.text = "XKCD"
        numLabel.text = "0"
        infoView.isHidden = true
        infoBackground.image = StyleKit.imageOfInfoBackground
        closeInfoButton.setImage(StyleKit.imageOfCloseInfoButton, for: .normal)
            
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
            DispatchQueue.main.async {
                self.titleLabel.text = loadedComic.title
                self.numLabel.text = "xkcd number \(loadedComic.num)"
            }
            getComicImage(comic: loadedComic)
        }
    }
    
    func getComicImage(comic: Comic){
        NetworkHelper.get(urlSting: comic.img, completionBlock: { (data) in
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.comicImage.image = image
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.comicImage
    }
}

