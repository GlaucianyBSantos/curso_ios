import SwiftUI

struct ConfirmacaoReservaView: View {

    let pacote: PacoteViagem

    var body: some View {

        VStack(spacing: 24) {

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(.green)

            Text("Reserva Confirmada")
                .font(.largeTitle)
                .bold()

            Text(pacote.titulo)
                .font(.title2)

            Text(pacote.precoFormatado)
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationTitle("Confirmação")
    }
}
