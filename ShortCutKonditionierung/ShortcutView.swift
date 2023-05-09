import SwiftUI


struct ShortcutView: View {
    
    @State var selectedTab: Tabs = .home
    @EnvironmentObject private var appState: AppState
    
    @State private var originalAppURL: URL? = URL(string: "your-app-scheme://")
    

    var body: some View {
        NavigationView {
        VStack {
        
            Text("App")
                .font(.title)
                .padding()
            
            Spacer()
            
                if appState.selectedShortcut == .sayHello {
                    Text("Hello")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    
                }
                
                
                // verschiedene Subviews pro Shortcut Intent anlegen
                // je nach dem welcher Shortcut ausgeführt wird -> entprechende View darstellen
                
                //
            
            Spacer()
            
            HStack{
                CountdownButtonView(originalAppURL: $originalAppURL, timerDuration: 10)
                                .padding()
                
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
                .padding(.bottom, 10)
            }
            }
                    
        }
        .navigationBarTitle(Text("shortcut"), displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        .padding()
        }
}


struct ShortcutView_Previews: PreviewProvider {
    static var previews: some View {
        ShortcutView()
    }
}
