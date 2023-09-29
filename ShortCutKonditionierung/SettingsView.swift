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
                    /*Section(header: Text(" Additional Settings")) {
                        NavigationLink(destination: NotificationsSettingsView()) {
                            HStack {
                                Text("notifications")
                            }
                        }
                    }*/
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
