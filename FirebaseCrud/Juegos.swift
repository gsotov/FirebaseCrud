//
//  Juegos.swift
//  FirebaseCrud
//
//  Created by Tecnova on 1/15/19.
//  Copyright © 2019 Gabriel Soto Valenzuela. All rights reserved.
//

import Foundation

class Juegos {
    
    var nombre:String?
    var genero:String?
    var id:String?
    var imagen:String?
    
    init(nombre:String?, genero:String?, id:String?, imagen:String?){
        self.nombre = nombre
        self.genero = genero
        self.id = id
        self.imagen = imagen
    }
}
