import SwiftUI

struct SettingsView: View {
    @Binding private var selectedTab: Tabs
    @EnvironmentObject private var settings: Settings
    
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("General Settings")) {
                        HStack {
                            Text("Timer Duration")
                            Spacer()
                            Stepper("\(settings.timerDuration) seconds", value: $settings.timerDuration, in: 1...60)
                        }
                    }
                    NavigationLink(destination: NotificationsSettingsView()) {
                        HStack {
                            Text("notifications")
                        }
                    }
                    NavigationLink(destination: BreatheSettingsView()) {
                        HStack {
                            Text("breathe")
                        }
                    }
                    NavigationLink(destination: ShockPictureSettingsView()) {
                        HStack {
                            Text("shock picture")
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                
                Spacer()
                
                NavigationBar(selectedTab: $selectedTab)
            }
            .navigationBarTitle(Text("settings"), displayMode: .inline)
        }
    }
}

struct NotificationsSettingsView: View {
    var body: some View {
        Text("Notifications Settings View")
            .navigationBarTitle(Text("notifications"))
    }
}

struct BreatheSettingsView: View {
    var body: some View {
        Text("Conditioning Methods Settings View")
            .navigationBarTitle(Text("conditioning methods"))
    }
}

/*struct ShockPictureSettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        List {
            ForEach(settings.images, id: \.self) { image in
                HStack {
                    Text(image)
                    Spacer()
                    Toggle("", isOn: Binding(
                        get: { self.settings.selectedImages.contains(image) },
                        set: { isSelected in
                            if isSelected {
                                self.settings.selectedImages.append(image)
                            } else {
                                self.settings.selectedImages.removeAll { $0 == image }
                            }
                        }
                    ))
                }
            }
        }
        .navigationBarTitle(Text("Shock Pictures"))
    }
}*/
struct ShockPictureSettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        List {
            ForEach(settings.allImages, id: \.self) { image in
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 50, height: 50)
                    
                    Text(image)
                    
                    Spacer()
                    
                    Button(action: {
                        if let index = settings.selectedImages.firstIndex(of: image) {
                            settings.selectedImages.remove(at: index)
                        } else {
                            settings.selectedImages.append(image)
                        }
                    }) {
                        Image(systemName: settings.selectedImages.contains(image) ? "checkmark.square" : "square")
                    }
                }
            }
        }
        .navigationBarTitle(Text("Shock Pictures"))
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant(.settings))
            .environmentObject(Settings())
    }
}


