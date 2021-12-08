//
//  Session.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 08.12.2021.
//

import Foundation

final class Session { //не разрешаем наследоваться
    
    private init() {} //не разрешаем конструктор
    
    static let shared = Session() //храниться в глобальной static память
    
    var token: String = ""
    var userId: String = ""
}
