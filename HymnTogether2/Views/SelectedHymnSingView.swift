//
//  SelectedHymnSing.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/30/24.
//

import SwiftUI

struct SelectedHymnSingView: View {
    let hymnSing: HymnSingModel
    @EnvironmentObject var peopleVM: PeopleViewModel
    
    func formatDate(timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
    
    var body: some View {
        let person = peopleVM.getPerson(id: hymnSing.personId)
        VStack {
            MapView(hymnSing: hymnSing, height: 300)
            HStack {
                VStack(alignment: .leading, spacing: 15){
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Lead").bold().font(.title3)
                        HStack(spacing: 10) {
                            AsyncImage(url: URL(string: person.avatar)) { result in
                                result.image?
                                    .resizable()
                                    .frame(width: 25.0, height: 25.0)
                                        .cornerRadius(.infinity)
                            Text(person.name).bold()
                            Spacer()
                        }
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Occuring").bold().font(.title3)
                        Text(formatDate(timeInterval: hymnSing.date))
                    }
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description").bold().font(.title3)
                        Text(hymnSing.description)
                    }
                    Spacer()
                }.padding()
                Spacer()
            }
        }.navigationTitle(hymnSing.name)
    }
}
}

#Preview {
    SelectedHymnSingView(hymnSing: HymnSingModel())
        .environmentObject(PersonViewModel())
}
