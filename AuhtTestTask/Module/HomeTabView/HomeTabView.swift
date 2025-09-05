//
//  HomeTabView.swift
//  AuhtTestTask
//
//  Created by Павел Калинин on 04.09.2025.
//

import SwiftUI

struct HomeTabView: View {
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .background
        
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    VStack {
                        Image(.giftTab)
                            .renderingMode(.template)
                        Text("Gifts")
                    }
                }
            
            Text("Gifts")
                .tabItem {
                    VStack {
                        Image(.flowerTab)
                            .renderingMode(.template)
                        Text("Gifts")
                    }
                }
            
            Text("Events")
                .tabItem {
                    VStack {
                        Image(.calendarTab)
                            .renderingMode(.template)
                        Text("Events")
                    }
                }
            
            Text("Cart")
                .tabItem {
                    VStack {
                        Image(.cartTab)
                            .renderingMode(.template)
                        Text("Cart")
                    }
                }
            
            Text("Profile")
                .tabItem {
                    VStack {
                        Image(.gearTab)
                            .renderingMode(.template)
                        Text("Profile")
                    }
                }
        }
        .tint(.black)
        
    }
}

#Preview {
    HomeTabView()
}
