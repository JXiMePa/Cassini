//
//  ImageViewController.swift
//  Cassini
//
//  Created by Tarasenco Jurik on 31.03.2018.
//  Copyright © 2018 Tarasenco Jurik. All rights reserved.
//
// MODEL!!!
import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    //olveis need UIScrollViewDelegate  to zoom.
    
    var imageURL: URL? {
        didSet {
            image = nil
          //  imageView.sizeToFit() // вернуть розмер 0.
          //  scrollView.contentSize = imageView.frame.size
          //ушло в image{set{}}
            if view.window != nil { //проверка MVC на екране?
            fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            
            // когда устанавлеваю изменяю розмер
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size //"?"-autlets not set jet!
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //теперь я на екране!(viewDidAppear)
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
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
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageView = UIImageView()
    
    private func fetchImage() {
        if let url = imageURL {
            spinner?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async { //[waek self] in // держит! пока не виполнит.
                //            do {
                let urlCOntents = try? Data(contentsOf: url)
                //           } catch let error {} // поймать Ошибку!
                DispatchQueue.main.async {
                    if let imageData = urlCOntents, url == self.imageURL {
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
    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil {
//            imageURL = DemoURLs.stanford
//        }
    }
 }

