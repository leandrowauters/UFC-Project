//
//  LanguageClient.swift
//  UFC-Fighter-Practice
//
//  Created by Leandro Wauters on 1/4/19.
//  Copyright © 2019 Leandro Wauters. All rights reserved.
//

import Foundation

struct LanguageClient {
    static var chosenLanguage: Language!
    
    enum Language {
        case english
        case spanish
    }
    static func translateToSpanish(word: String) -> String {//Return A String????
        enum SpanishTranslations: String {
        case flyweight = "Flyweight"
        case bantamweight = "Bantamweight"
        case featherweight = "Featherweight"
        case lightweight = "Lightweight"
        case welterweight = "Welterweight"
        case middleweight = "Middleweight"
        case lightHeavyweight = "Light_Heavyweight"
        case heavyweight = "Heavyweight"
        case womenStrawweight = "Women_Strawweight"
        case womenFlyweight = "Women_Flyweight"
        case womenBantamweight = "Women_Bantamweight"
        case womenFeatherweight = "Women_Featherweight"
        case notFighting = "NotFighting"
        case active = "Active"
        }
        let wordToTranslate = SpanishTranslations(rawValue: word)!
        switch wordToTranslate {
        case .flyweight:
            return "Peso mosca"
        case .bantamweight:
            return "Peso gallo"
        case .featherweight:
            return "Peso pluma"
        case .lightweight:
            return "Peso ligero"
        case .welterweight:
            return "Peso welter"
        case .middleweight:
            return "Peso mediano"
        case .lightHeavyweight:
            return "Peso semipesado"
        case .heavyweight:
            return "Peso pesado"
        case .womenFlyweight:
            return "Peso mosca femenino"
        case .womenStrawweight:
            return "Peso paja femenino"
        case .womenBantamweight:
            return "Peso gallo femenino"
        case .womenFeatherweight:
            return "Peso pluma femenino"
        case .notFighting:
            return "Retirado"
        case .active:
            return "Activo"
        }
    }
}

