import SwiftUI


struct ShortcutView: View {
    
    @State var selectedTab: Tabs = .home
    @EnvironmentObject private var appState: AppState
    

    var body: some View {
        NavigationView {
        VStack {
            
            //Text("App: \(appName)")
            Text("App")
                .font(.title)
                .padding()
            
            Spacer()
            
            if appState.showShortcutView == true {
                
                if appState.selectedShortcut == .sayHello {
                    Text("Hello")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                }
                
                
                // verschiedene Subviews pro Shortcut Intent anlegen
                // je nach dem welcher Shortcut ausgeführt wird -> entprechende View darstellen
                
                //
                
                /*Button("Öffne App") {
                    if let url = URL(string: appState.originalAppURLScheme) {
                        UIApplication.shared.open(url)
                        
                    }
                }*/
            }
            
            HStack{
                
                Spacer()
                
                NavigationLink(destination: HomeView(selectedTab: $selectedTab)) {
                Image(systemName: "house")
                    .font(.title)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Circle())
                    .frame(width: 40, height: 24)
            }
            .padding(.bottom, 10)}
            
        }
        .navigationBarTitle(Text("shortcut"), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        .padding()
        }
    }
    
    func openOriginalApp() {
           if let urlScheme = appState.originalAppURLScheme, let url = URL(string: urlScheme) {
               UIApplication.shared.open(url, options: [:]) { success in
                   if !success {
                       print("Error: could not open the original app")
                   }
               }
           }
       }
}

struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView()
    }
}
