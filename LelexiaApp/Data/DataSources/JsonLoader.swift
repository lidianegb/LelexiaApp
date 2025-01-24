//
//  JsonLoader.swift
//  LelexiaApp
//
//  Created by Lidiane Gomes Barbosa on 22/01/25.
//

import Foundation

class JSONLoader {
    static func load<T: Decodable>(_ type: T.Type, fromFile fileName: String, withExtension fileExtension: String = "json") -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension),
              let data = try? Data(contentsOf: url) else {
            print("Erro: Não foi possível localizar o arquivo \(fileName).\(fileExtension)")
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Erro ao decodificar o arquivo \(fileName): \(error)")
            return nil
        }
    }
}
