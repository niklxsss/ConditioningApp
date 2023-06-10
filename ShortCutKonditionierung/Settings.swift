import SwiftUI

class Settings: ObservableObject {
    
    var picturesInt: Int {
            return allImages.count - 2
        }
    
    @Published var timerDuration: Int {
        didSet {
            if timerDuration < 5 {
                timerDuration = 5
            }
            UserDefaults.standard.set(timerDuration, forKey: "timerDuration")
        }
    }
    
    @Published var notificationTime: Int {
        didSet {
            if notificationTime < 1 {
                notificationTime = 1
            } else if notificationTime > 29 {
                notificationTime = 29
            }
            UserDefaults.standard.set(notificationTime, forKey: "notificationTime")
        }
    }
    
    @Published var selectedImages: [String] {
        didSet {
            saveSelectedImages()
            updateSelectedImages()
        }
    }
    
    @Published var allImages: [String]
        
    @Published var infoTextsShortcut: [String]
    
    init() {
        let loadedTimerDuration = UserDefaults.standard.integer(forKey: "timerDuration")
        self.timerDuration = loadedTimerDuration < 5 ? 10 : loadedTimerDuration
        
        let loadedNotificationTime = UserDefaults.standard.integer(forKey: "notificationTime")
        self.notificationTime = loadedNotificationTime < 1 || loadedNotificationTime > 29 ? 5 : loadedNotificationTime
        
        if let data = UserDefaults.standard.data(forKey: "selectedImages"),
           let decodedImages = try? JSONDecoder().decode([String].self, from: data) {
            self.selectedImages = decodedImages
        } else {
            self.selectedImages = []
        }
        
        self.allImages = ["rot","rot2","rot1"]

        self.infoTextsShortcut = [
                    "Die Nutzung von Social Media vor dem Schlafengehen kann zu Schlafstörungen und schlechter Schlafqualität führen.",
                    "Exzessive Nutzung von Social Media kann zu erhöhten Depressionen und Angstzuständen führen.",
                    "Die ständige Sorge, etwas Wichtiges oder Spaßiges zu verpassen, kann durch den Gebrauch von Social Media verstärkt werden.",
                    "Social Media ermöglicht Cybermobbing, das schwerwiegende psychische Folgen für die Opfer haben kann.",
                    "Die ständige Konfrontation mit perfekt inszenierten Bildern auf Social Media kann zu Selbstwertproblemen und Unzufriedenheit mit dem eigenen Leben führen.",
                    "Social Media kann süchtig machen und zu exzessivem Gebrauch führen, der andere Lebensbereiche beeinträchtigt.",
                    "Die Nutzung von Social Media birgt Risiken für die Privatsphäre und den Schutz persönlicher Daten.",
                    "Social Media kann ablenken und zu einem Verlust an Produktivität in Schule, Arbeit und Alltag führen.",
                    "Übermäßiger Gebrauch von Social Media kann zu sozialer Isolation und einem Mangel an echten menschlichen Interaktionen führen.",
                    "Social Media kann zur Verbreitung von Falschinformationen und Fake News beitragen, die reale Auswirkungen auf die Gesellschaft haben können."
        ]
        
        updateSelectedImages()
    }

    func updateSelectedImages() {
        if selectedImages.count < picturesInt {
            let additionalImagesNeeded = picturesInt - selectedImages.count
            let remainingImages = allImages.filter { !selectedImages.contains($0) }
            
            if additionalImagesNeeded <= remainingImages.count {
                for _ in 0..<additionalImagesNeeded {
                    if let randomImage = remainingImages.randomElement() {
                        selectedImages.append(randomImage)
                    }
                }
            } else {
                selectedImages.append(contentsOf: remainingImages)
            }
            
            saveSelectedImages()
        }
    }

    func saveSelectedImages() {
        let encodedData = try? JSONEncoder().encode(selectedImages)
        UserDefaults.standard.set(encodedData, forKey: "selectedImages")
    }

    func saveAllImages() {
        let encodedData = try? JSONEncoder().encode(allImages)
        UserDefaults.standard.set(encodedData, forKey: "allImages")
    }
    
    func saveInfoTexts() {
        UserDefaults.standard.set(infoTextsShortcut, forKey: "infoTexts")
    }
}
