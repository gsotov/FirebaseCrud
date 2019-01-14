//
//  InicioViewController.swift
//  FirebaseCrud
//
//  Created by Tecnova on 1/14/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit
import FirebaseAuth

class InicioViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let correo = Auth.auth().currentUser?.email
        print("el correo electronico es: \(correo!)")
    }
    
    @IBAction func salir(_ sender: UIButton)
    {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "login", sender: self)
    }
    
}
