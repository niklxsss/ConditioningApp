import SwiftUI

class Settings: ObservableObject {
    
    @Published var timerDuration: Int {
        didSet {
            if timerDuration < 5 {
                timerDuration = 5
            }
            UserDefaults.standard.set(timerDuration, forKey: "timerDuration")
        }
    }

    @Published var selectedImages: [String] {
        didSet {
            saveSelectedImages()
            updateSelectedImages()
        }
    }

    @Published var allImages: [String] {
        didSet {
            saveAllImages()
        }
    }

    init() {
        let loadedTimerDuration = UserDefaults.standard.integer(forKey: "timerDuration")
        self.timerDuration = loadedTimerDuration < 5 ? 10 : loadedTimerDuration

        if let data = UserDefaults.standard.data(forKey: "selectedImages"),
           let decodedImages = try? JSONDecoder().decode([String].self, from: data) {
            self.selectedImages = decodedImages
        } else {
            self.selectedImages = []
        }

        if let data = UserDefaults.standard.data(forKey: "allImages"),
           let decodedImages = try? JSONDecoder().decode([String].self, from: data) {
            self.allImages = decodedImages
        } else {
            self.allImages = ["rot","rot2","rot1"]
        }
        
        updateSelectedImages()
    }

    func updateSelectedImages() {
        if selectedImages.count < 2 {
            let additionalImagesNeeded = 2 - selectedImages.count
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
}
