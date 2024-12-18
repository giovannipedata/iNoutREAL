//
//  ContentView.swift
//  InNout
//
//  Created by Giovanni Pedata on 17/12/24.
//

import SwiftUI

struct ContentView: View {
    // Variabili di stato per i dati del badge
    @State private var name = "Giovanni Pedata"
    @State private var cohort = "Afternoon Cohort"
    @State private var badgeID = "#199"
    
    @State private var isCalendarPresented = false // Stato della modale calendario
    @State private var isBadgeModalPresented = false // Stato della modale badge in/out
    @State private var lastAction = "" // Stato per azione effettuata

    var body: some View {
        NavigationView {
            VStack {
                // Logo e data
                VStack(spacing: 5) {
                    Text("iNout")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("**Today,**")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(getCurrentDate())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                
                Spacer()

                // Badge personale (Pulsante per aprire la modale)
                Button(action: {
                    isBadgeModalPresented.toggle()
                }) {
                    VStack {
                        Text("Apple Developer Academy")
                            .font(.headline)
                            .padding(.top, 10)

                        VStack {
                            // Immagine placeholder (sostituibile con immagine utente)
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding(.bottom, 10)

                            // Dati badge
                            Text(name)
                                .font(.body)
                                .foregroundColor(.black)
                            Text(cohort)
                                .foregroundColor(.gray)
                            Text(badgeID)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
                    .frame(width: 300, height: 250)
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                }
                .padding()
                .sheet(isPresented: $isBadgeModalPresented) {
                    BadgeActionView(lastAction: $lastAction)
                }

                // Visualizza l'ultima azione effettuata
                if !lastAction.isEmpty {
                    Text("Ultima Azione: \(lastAction)")
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("") // Rimuove titolo della NavigationView
            .toolbar {
                // Pulsante per aprire il calendario
                Button(action: {
                    isCalendarPresented.toggle()
                }) {
                    Image(systemName: "calendar")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .sheet(isPresented: $isCalendarPresented) {
                CalendarView() // Modale calendario
            }
        }
    }
    
    // Funzione per ottenere la data corrente
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
}

// Modale per le azioni Badge In e Badge Out
struct BadgeActionView: View {
    @Binding var lastAction: String // Stato per aggiornare l'azione
    @Environment(\.dismiss) var dismiss // Permette di chiudere la modale

    var body: some View {
        VStack(spacing: 30) {
            Text("Badge Actions")
                .font(.title)
                .bold()
            
            // Pulsante Badge In
            Button(action: {
                lastAction = "Badge In effettuato alle \(getCurrentTime())"
                dismiss()
            }) {
                Text("Badge In")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            // Pulsante Badge Out
            Button(action: {
                lastAction = "Badge Out effettuato alle \(getCurrentTime())"
                dismiss()
            }) {
                Text("Badge Out")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
    
    // Funzione per ottenere l'orario corrente
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }
}

// Modale Calendario
struct CalendarView: View {
    var body: some View {
        VStack {
            Text("Calendario")
                .font(.title)
                .padding()
            Spacer()
            DatePicker("Seleziona Data", selection: .constant(Date()), displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}

