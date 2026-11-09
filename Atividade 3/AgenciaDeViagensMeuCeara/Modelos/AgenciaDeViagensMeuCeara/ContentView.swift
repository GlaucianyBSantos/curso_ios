import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 16) {

                    Image("jericoacoara")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 130)
                        .clipped()
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )

                    Text("Agência de Viagens")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    Text("Meu Ceará")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.primary)

                    Text("Viva as cores e os caminhos do Ceará.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Spacer()
                }
                .padding(.top, 30)
            }
            .navigationTitle("Explorar Viagens")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ContentView()
}
