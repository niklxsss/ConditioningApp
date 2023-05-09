import SwiftUI

struct SettingsView: View {
    
    @Binding private var selectedTab: Tabs
    
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
    
    var body: some View {
            NavigationView {
                VStack {
                    List {
                    NavigationLink(destination: NotificationsSettingsView()) {
                        HStack {
                            Text("notifications")
                        }
                    }
                    NavigationLink(destination: ConditioningMethodsSettingsView()) {
                        HStack {
                            Text("conditioning methods")
                        }
                    }
                    }
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

struct ConditioningMethodsSettingsView: View {
    var body: some View {
        Text("Conditioning Methods Settings View")
            .navigationBarTitle(Text("conditioning methods"))
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedTab: .constant(.settings))
    }
}

