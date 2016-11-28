//
//  ViewController.swift
//  DownloadImage
//
//  Created by Kostyantyn Runduyev on 11/29/16.
//  Copyright © 2016 Kostyantyn Runduyev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        if documentsPath.count > 0 {
            let documentDirectory = documentsPath[0]
            let imagePath = documentDirectory + "/bach.jpg"
            let loadedImage : UIImage? = UIImage(contentsOfFile: imagePath)
            
            if loadedImage != nil {
                image.image = loadedImage
            } else {
                let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Johann_Sebastian_Bach.jpg/260px-Johann_Sebastian_Bach.jpg")!
                
                let request = NSMutableURLRequest(url: url)
                
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    data, response, error in
                    
                    if error != nil {
                        print(error!)
                    } else {
                        if let data = data {
                            if let bachImage = UIImage(data: data) {
                                self.image.image = bachImage
                                
                                do {
                                    try UIImageJPEGRepresentation(bachImage, 0.95)?.write(to: URL(fileURLWithPath: imagePath))
                                } catch {
                                    
                                }
                                
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

