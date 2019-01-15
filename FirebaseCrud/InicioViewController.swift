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
import FirebaseStorage

class InicioViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    @IBOutlet weak var juego: UITextField!
    @IBOutlet weak var genero: UITextField!
    @IBOutlet weak var vistePicker: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var cargador: UIActivityIndicatorView!
    
    var imagen = UIImage()
    var plataforma : String = ""
    let plataformas = ["PLAYSTATION 4","XBOX ONE","NINTENDO SWITCH","PC"]
    
    var ref: DatabaseReference!
    var idFirebase = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        let correo = Auth.auth().currentUser?.email
        idFirebase = (Auth.auth().currentUser?.uid)!
        print(idFirebase)
        
        print("el correo electronico es: \(correo!)")
        
        //se esta referenciando a la BBDD de firebase
        ref = Database.database().reference()
        cargador.isHidden = true
        
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
        
        let storage = Storage.storage().reference()
        let nombreImagen = UUID()
        let directorio = storage.child("imagenes/\(nombreImagen)")
        let metaData = StorageMetadata()
        
        metaData.contentType = "image/png"
        directorio.putData(imagen.pngData()!, metadata: metaData) { (data, error) in
            if error == nil{
                print("cargo la imagen")
                self.cargador.stopAnimating()
                self.cargador.isHidden = true
            }
            else{
                if let error = error?.localizedDescription{
                    print("error al subir imagen en Firebase ", error)
                }else{
                    print("error en el codigo")
                }
            }
        }
        
        let campos = ["nombre" : juego.text!,
                      "genero" : genero.text!,
                      "id": id,
                      "portada": String(describing: directorio)]
        
        ref.child(idFirebase).child(plataforma).child(id!).setValue(campos)
        cargador.isHidden = false
        cargador.startAnimating()
        print("guardo")
        limpiar()
        
    }
    
    @IBAction func tomarFoto(_ sender: UIBarButtonItem)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let imagenTomada = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        imagen = imagenTomada
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
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
