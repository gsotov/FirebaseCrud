//
//  EditarViewController.swift
//  FirebaseCrud
//
//  Created by Tecnova on 1/15/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EditarViewController: UIViewController {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var genero: UITextField!
    
    var ref: DatabaseReference!
    var editarJuegos: Juegos!
    var plataforma: String!
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        nombre.text = editarJuegos.nombre
        genero.text = editarJuegos.genero
        id = editarJuegos.id!
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editar(_ sender: UIButton)
    {
        let campos = ["nombre": nombre.text!,
                      "genero": genero.text!,
                      "id": id]
        
        ref.child(plataforma).child(id).setValue(campos)
        dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
