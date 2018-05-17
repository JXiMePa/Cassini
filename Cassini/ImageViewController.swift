//
//  ImageViewController.swift
//  Cassini
//
//  Created by Tarasenco Jurik on 31.03.2018.
//  Copyright © 2018 Tarasenco Jurik. All rights reserved.
//
import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    //MARK: Items, Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            //zoom min/max
            
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    var imageView = UIImageView()
    
    var imageURL: URL? {
        didSet {
            image = nil
          //  imageView.sizeToFit() // вернуть розмер 0.
          //  scrollView.contentSize = imageView.frame.size
          //ушло в image{set{}}
            if view.window != nil { //проверка MVC на екране?
            getMyImage()
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            spinner?.stopAnimating()
            scrollView?.contentSize = imageView.frame.size
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
   
    //MARK: LifeCycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //view's was add to a view hierarchy
        if imageView.image == nil {
            getMyImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if imageURL == nil {
        //            imageURL = DemoURLs.stanford
        //        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private func getMyImage() {
        if let url = imageURL {
            spinner?.startAnimating() //waiting symbol
            
            
            DispatchQueue.global(qos: .userInitiated).async { //[waek self] in // держит! пока не виполнит.
                //            do {
                let urlContents = try? Data(contentsOf: url)
                //           } catch let error {} // поймать Ошибку!
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self.imageURL {
                        self.image = UIImage(data: imageData) //self. - check memory cycle!
                        //ушло в image{set{}}
                        //imageView.sizeToFit()
                        //.sizeToFit() - розмер которий будет соответствовать розмеру картинки
                        //scrollView.contentSize = imageView.frame.size
                        // розмер scrollView = imageView розмеру.(иначе 0.0 и прокрутки не будет)
                    }
                }
            }
        }
    }
 }

