//
//  2page.swift
//  InNout
//
//  Created by Giovanni Pedata on 18/12/24.
//
import SwiftUI

struct TimeSelectionView: View {
    // Variabili di stato per gestire gli alert e le icone
    @State private var isAlertPresented = false
    @State private var alertMessage = ""
    @State private var currentAction = "" // Differenzia tra "IN" e "OUT"

    // Stati per mostrare le icone badge
    @State private var showInBadge = false
    @State private var showOutBadge = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                // Titolo e data
                VStack(alignment: .leading) {
                    Text("iNout")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)

                    Text("**Today,**")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("9 Dec. '24")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // Tabella con IN e OUT
                VStack {
                    HStack(spacing: 0) {
                        // Colonna IN
                        VStack {
                            Text("IN")
                                .font(.headline)
                                .fontWeight(.bold)
                                .underline()
                                .padding(.bottom, 5)

                            Button(action: {
                                // Mostra alert per IN
                                currentAction = "IN"
                                alertMessage = "Are you sure you wanna in?"
                                isAlertPresented.toggle()
                            }) {
                                Text("14:00:00")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(width: 120, height: 50)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }

                            // Icona Badge per IN
                            if showInBadge {
                                Image(systemName: "checkmark.seal.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.green)
                                    .padding(.top, 5)
                            }
                        }
                        .frame(width: 150, height: 120)
                        .border(Color.blue, width: 1)

                        // Colonna OUT
                        VStack {
                            Text("OUT")
                                .font(.headline)
                                .fontWeight(.bold)
                                .underline()
                                .padding(.bottom, 5)

                            Button(action: {
                                // Mostra alert per OUT
                                currentAction = "OUT"
                                alertMessage = "Are you sure you wanna out?"
                                isAlertPresented.toggle()
                            }) {
                                Text("18:00:00")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(width: 120, height: 50)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }

                            // Icona Badge per OUT
                            if showOutBadge {
                                Image(systemName: "checkmark.seal.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.green)
                                    .padding(.top, 5)
                            }
                        }
                        .frame(width: 150, height: 120)
                        .border(Color.blue, width: 1)
                    }
                }
                .padding(.top, 30)

                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarBackButtonHidden(false)
            .alert(isPresented: $isAlertPresented) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text(alertMessage),
                    primaryButton: .default(Text("Yes"), action: {
                        // Aggiungi l'icona sotto l'orario selezionato
                        if currentAction == "IN" {
                            showInBadge = true
                        } else if currentAction == "OUT" {
                            showOutBadge = true
                        }
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
}

struct TimeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSelectionView()
    }
}

