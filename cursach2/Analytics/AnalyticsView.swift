//
//  AnalyticsView.swift
//  cursach2
//
//  Created by Роман Верко on 19.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct AnalyticsView: View {
    var body: some View {
        VStack{
            Text("Analytics")
                .fontWeight(.semibold)
                .padding()
                .font(.largeTitle)
                
            Image("bar-chart-label").resizable()
                       .aspectRatio(contentMode: .fit)
        }
       
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
