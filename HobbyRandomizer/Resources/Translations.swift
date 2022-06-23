//
//  TranslationsL.swift
//
//
//  Created by ICoon on 16.03.2022.
//
import Foundation

struct Translations{
    
    struct Casino{
        public static var play: String{
            "Translations.Casino.play".localized(Bundle.main)
        }
        
        public static var cheat: String{
            "Translations.Casino.cheat".localized(Bundle.main)
        }
    }
    
    struct Show{
        public static var startRandom: String{
            "Translations.Show.startRandom".localized(Bundle.main)
        }
    }
    
    struct Menu{
        public static var mainTitle: String{
            "Translations.Menu.mainTitle".localized(Bundle.main)
        }
        
        public static var itemCasino: String{
            "Translations.Menu.itemCasino".localized(Bundle.main)
        }
        
        public static var itemTest: String{
            "Translations.Menu.itemTest".localized(Bundle.main)
        }
        
        public static var itemCreate: String{
            "Translations.Menu.itemCreate".localized(Bundle.main)
        }
        
        public static var itemHobby: String{
            "Translations.Menu.itemHobby".localized(Bundle.main)
        }
        
        public static var itemWorkInProgress: String{
            "Translations.Menu.itemWorkInProgress".localized(Bundle.main)
        }
        
        public static var itemTodo: String{
            "Translations.Menu.itemTodo".localized(Bundle.main)
        }
        
        public static var itemFiles: String{
            "Translations.Menu.itemFiles".localized(Bundle.main)
        }
    }
}

