//
//  InicioViewController.swift
//  FirebaseCrud
//
//  Created by Tecnova on 1/14/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class InicioViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var juego: UITextField!
    @IBOutlet weak var genero: UITextField!
    @IBOutlet weak var vistePicker: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    var plataforma : String = ""
    let plataformas = ["PLAYSTATION 4","XBOX ONE","NINTENDO SWITCH","PC"]
    
    var ref: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        let correo = Auth.auth().currentUser?.email
        print("el correo electronico es: \(correo!)")
        
        //se esta referenciando a la BBDD de firebase
        ref = Database.database().reference()
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return plataformas[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plataformas.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        plataforma = plataformas[row]
        vistePicker.text = plataformas[row]
    }
    
    @IBAction func guardar(_ sender: UIButton)
    {
        let id = ref.childByAutoId().key
        
        let campos = ["nombre" : juego.text!,
                      "genero" : genero.text!,
                      "id": id]
        
        ref.child(plataforma).child(id!).setValue(campos)
        print("guardo")
        
        limpiar()
        
    }
    
    @IBAction func salir(_ sender: UIButton)
    {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "login", sender: self)
    }
    
    func limpiar()
    {
        juego.text = ""
        genero.text = ""
    }    
}
