import SwiftUI
import Charts

struct HomeView: View {
    
    @Binding private var selectedTab: Tabs
    @EnvironmentObject private var appState: AppState
    @State private var pickerIsPresented = false
    @StateObject var screenTimeModel = ScreenTimeModel()
    
    let utils = Utils()
        
    init(selectedTab: Binding<Tabs>) {
        _selectedTab = selectedTab
    }
        
    var body: some View {
            NavigationView {
                VStack {
                    
                    Spacer()
                    Button("Apps auswählen") {
                        pickerIsPresented = true
                    }
                    .familyActivityPicker(isPresented: $pickerIsPresented, selection: $screenTimeModel.activitySelection)
                    
                    Spacer()
                    
                    NavigationBar(selectedTab: $selectedTab)
                    
                }
                .navigationBarTitle(Text("home"), displayMode: .inline)
            }
    }
}
