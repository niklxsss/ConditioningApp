import SwiftUI

enum Tabs: Int{
    case statistics = 0
    case home = 1
    case settings = 2
}

struct NavigationBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View{
        
        HStack{
            Button{
                selectedTab = .statistics
    
            } label: {
                CustomNavBarButton(buttonText: "statistics", imageName: "chart.bar", isAcitve: selectedTab == .statistics)
            }
            .tint(Color("icons-secondary"))
            
            Button{
                selectedTab = .home
            } label: {
                CustomNavBarButton(buttonText: "home", imageName: "house", isAcitve: selectedTab == .home)
            }
            .tint(Color("icons-secondary"))
            
            Button{
                selectedTab = .settings
            } label: {
                CustomNavBarButton(buttonText: "settings", imageName: "gear", isAcitve: selectedTab == .settings)
            }
            .tint(Color("icons-secondary"))
        }
        .frame(height: 80)
        .frame(maxHeight: .infinity, alignment: .bottom)
        
    }
}


/*struct NavigationBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View{
        
       
        
        HStack{
            
            Button{
                selectedTab = .statistics
        
                
            } label: {
                
                CustomNavBarButton(buttonText: "statistics", imageName: "chart.bar", isAcitve: selectedTab == .statistics)
                
            }
            .tint(Color("icons-secondary"))
            
            Button{
                selectedTab = .home
                
            } label: {
                
                CustomNavBarButton(buttonText: "home", imageName: "house", isAcitve: selectedTab == .home)
                
            }
            .tint(Color("icons-secondary"))
            
            Button{
                selectedTab = .settings
                
            } label: {
                
                CustomNavBarButton(buttonText: "settings", imageName: "gear", isAcitve: selectedTab == .settings)
                
            }
            .tint(Color("icons-secondary"))
        }
        .frame(height: 80)
        .frame(maxHeight: .infinity, alignment: .bottom)
        
        //Color.clear
          //  .background(.ultraThinMaterial)
            //.blur(radius: 10)
        
    
    }

    
}*/

/*struct NavigationBar: View {

    var title = ""
    
    var body: some View{
        ZStack{
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
            
            Text(title)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
        }
        .frame(height: 70)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}*/

struct NavigationBar_Previews: PreviewProvider{
    
    static var previews :some View{
        NavigationBar(selectedTab: .constant(.home))
.previewInterfaceOrientation(.portrait)
    }
}

