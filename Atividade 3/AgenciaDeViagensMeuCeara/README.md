
# Agência de Viagens Meu Ceará

Aplicativo desenvolvido em SwiftUI como atividade prática da Formação iOS pela Proway e Capgemini ministrado pelo Professor Ralf Lima.

## Objetivo

Simular uma agência de viagens permitindo que o usuário:

- Explore pacotes turísticos;
- Visualize detalhes de cada destino;
- Adicione e remova pacotes favoritos;
- Realize reservas de forma ilustrativa;
- Gerencie suas reservas.

## Funcionalidades

### Explorar Viagens

- Lista de pacotes turísticos;
- Busca de destinos;
- Ordenação por preço;
- Exibição de:
  - imagem;
  - título;
  - localização;
  - quantidade de diárias;
  - preço.

### Detalhes do Pacote

- Imagem de destaque;
- Informações da viagem;
- Informações da hospedagem;
- Adicionar ou remover dos favoritos;
- Reserva ilustrativa do pacote.

### Favoritos

- Lista apenas dos destinos favoritados;
- Atualização automática dos favoritos.

### Reservas

- Registro de reservas realizadas;
- Exibição dos pacotes reservados;
- Cancelamento de reservas.

## Estrutura do Projeto

```text
AgenciaDeViagensMeuCeara
├── Assets.xcassets
├── Componentes
│   └── PacoteCardView.swift
├── Modelos
│   ├── DadosPacotes.swift
│   └── PacoteViagem.swift
├── Telas
│   ├── ConfirmacaoReservaView.swift
│   ├── DetalhesPacoteView.swift
│   ├── FavoritosView.swift
│   └── ReservasView.swift
├── ContentView.swift
├── MainTabView.swift
└── MyApp.swift

Tecnologias Utilizadas
Swift
SwiftUI
NavigationStack
NavigationLink
TabView
ScrollView
@State
@Binding
Conceitos Praticados
Programação orientada a componentes;
Modelagem de dados com Structs;
Gerenciamento de estado em SwiftUI;
Navegação entre telas;
Compartilhamento de dados com Binding;
Organização de projeto em pastas;
Interface declarativa.
Autor

Glauciany Brandão dos Santos

Formação iOS – Professor Ralf Lima
