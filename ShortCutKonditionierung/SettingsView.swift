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
                    Section(header: Text("info")) {
                        NavigationLink(destination: InfoSettingsView()) {
                            HStack {
                                Text("usage information")
                            }
                        }
                    }
                    Section(header: Text(" Additional Settings")) {
                        NavigationLink(destination: NotificationsSettingsView()) {
                            HStack {
                                Text("notifications")
                            }
                        }
                        
                        NavigationLink(destination: ShockPictureSettingsView()) {
                            HStack {
                                Text("shock picture")
                            }
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
    @EnvironmentObject var settings: Settings
    let notificationTimes = Array(1...29)
    
    var body: some View {
        List {
            Section(header: Text("Notification Toggle")) {
                            Toggle(isOn: $settings.notificationsEnabled) {
                                Text("Enable Notifications")
                            }
                        }
            Picker(selection: $settings.notificationTime, label: Text("Notification time before streak ends")) {
                ForEach(notificationTimes, id: \.self) {
                    Text("\($0) mins")
                }
            }
        }
        .navigationBarTitle(Text("Notifications"))
    }
}

struct InfoSettingsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                infoBox(title: "Available Shortcuts", text: "This app offers three types of shortcuts:", bulletPoints: [
                    "Warning Message: The app automatically selects one of ten pre-stored messages to display to the user before accessing the actual app.",
                    "Shock Image: The app automatically selects one of ten pre-stored images to display to the user before accessing the actual app.",
                    "Breathing Exercise: The app shows the user a breathing animation, helping them to calm down before accessing the actual app."
                ])
                infoBox(title: "Set up Shortcut", text: "", bulletPoints: [
                    "Open the Shortcuts app.",
                    "Click on \"Automation\" in the navigation bar.",
                    "Continue to \"Create Personal Automation\".",
                    "Select \"App\" under New Automation.",
                    "Choose the app before which you want the shortcut to trigger.",
                    "Click on \"Add Action\".",
                    "Select the \"ShortcutConditioning\" app.",
                    "Choose one of the available shortcuts.",
                    "In the empty text field, enter the internal app URL for the previously selected app. You can test it by pressing the play button at the bottom right.",
                    "The app opens in shortcut mode, thereby directly showing the selected shortcut."
                ])
                infoBox(title: "Streak", text: "If the user maintains usage time per app under half an hour for more than three consecutive days, a streak of 3 flames is displayed. For each additional day of less than 30 minutes of usage, the streak continues. Before the 30 minutes are exceeded, a notification is sent depending on the notification time stored.")
                infoBox(title: "Charts", text: "The charts display the usage time of the past 7 days. If the user double-clicks on a chart, it flips and shows a list of all usage times.")
                infoBox(title: "Correct Recording of Usage Time", text: "The usage time is correctly recorded if the open app is closed in such a way that the \"back\" button to the app is visible in the top left corner.")
            }
            .padding()
        }
        .navigationBarTitle(Text("Usage Information"), displayMode: .inline)
    }

    private func infoBox(title: String, text: String, bulletPoints: [String]? = nil) -> some View {
        GroupBox {
            VStack {
                HStack {
                    Text(title)
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text(text)
                        .fontWeight(.medium)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                    
                    if let points = bulletPoints {
                        bulletPointList(points: points)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
            }
        }
        .frame(width: 375)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.bottom)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }

    private func bulletPointList(points: [String]) -> some View {
        ForEach(points.indices, id: \.self) { idx in
            HStack(alignment: .top) {
                Text("•")
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)
                Text(points[idx])
                    .foregroundColor(.secondary)
                    .padding(.leading, 5)
            }
            .padding(.vertical, 2)
        }
    }

}



struct ShockPictureSettingsView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        List {
            ForEach(settings.allImages, id: \.self) { image in
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                    
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


