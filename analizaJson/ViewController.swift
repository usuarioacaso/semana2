//
//  ViewController.swift
//  analizaJson
//
//  Created by Adrian Camacho Soriano on 19/03/16.
//  Copyright © 2016 Adrian Camacho Soriano acaso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var capturaISBN: UITextField!
    
    @IBAction func implementaISBN(sender: UITextField) {
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=\(capturaISBN.text!)"
        let url = NSURL(string: urls)
        if let datos:NSData? = NSData(contentsOfURL: url!) {
            do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dic1 = json as! NSDictionary
            let dic2 = dic1[capturaISBN.text!] as! NSDictionary
            let dic3 = dic2["title"] as! String
            self.muestraTitulo.text = dic3 as String
            let dic4 = dic2["authors"] as! NSArray
            dic4.enumerateObjectsUsingBlock({model, index, stop in
                let dic5 = model["name"] as! String
                self.muestraAutor.text = dic5
                })
            let dic6 = dic2["cover"] as! NSDictionary
            let dic7 = dic6["large"] as! String
                let url:NSURL = NSURL(string: dic7)!
                let datoimg:NSData = NSData(contentsOfURL: url)!
                muestraPortada.image = UIImage(data: datoimg)
            }
            catch{
                
            }
            
        }else{
            self.muestraTitulo.text = "No hubo respuesta de la web !!"
        }
        capturaISBN.resignFirstResponder()
    }
    @IBOutlet weak var muestraTitulo: UITextView!
    
    @IBOutlet weak var muestraAutor: UITextView!
    
    @IBOutlet weak var muestraPortada: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

