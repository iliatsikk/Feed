//
//  ContentView.swift
//  Feed
//
//  Created by Ilia Tsikelashvili on 10.05.25.
//

import SwiftUI
import Domain
import Networking

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
    .task {
      await getData()
    }
  }

  private func getData() async {
    let repo = ListRepository(apiClient: APIClient())
    do {
      let data = try await repo.getListOfImages(page: 1, perPage: 20)
      print(data)
    } catch {
      print(error)
    }
  }
}

#Preview {
  ContentView()
}
