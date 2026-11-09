import SwiftUI

struct MainTabView: View {

    @State private var favoritos: Set<UUID> = []

    @State private var reservas: [PacoteViagem] = []

    var body: some View {

        TabView {

            ContentView(
                favoritos: $favoritos,
                reservas: $reservas
            )
            .tabItem {
                Label(
                    "Explorar",
                    systemImage: "airplane"
                )
            }

            FavoritosView(
                favoritos: $favoritos,
                reservas: $reservas
            )
            .tabItem {
                Label(
                    "Favoritos",
                    systemImage: "heart.fill"
                )
            }

            ReservasView(
                reservas: $reservas
            )
            .tabItem {
                Label(
                    "Reservas",
                    systemImage: "ticket.fill"
                )
            }
        }
    }
}

#Preview {
    MainTabView()
}
