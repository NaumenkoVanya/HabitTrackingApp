//
//  ContentView.swift
//  HabitTrackingApp
//
//  Created by Ваня Науменко on 7.03.24.
//
import SwiftUI

struct HabitTrackingAppTwo: View {
    @State private var habits = [Habit]()

    var body: some View {
        NavigationView {
            List {
                ForEach($habits) { habit in
                    HabitRow(habit: habit)
                }
                .onDelete(perform: delete)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: add) {
                        Label("Add Habit", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    func add() {
        let newHabit = Habit(name: "New Habit", description: "", completed: true)
        habits.append(newHabit)
    }
    
    func delete(offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
}

struct HabitRow: View {
    @Binding var habit: Habit
    
    var body: some View {
        NavigationLink {
            HabitDetailView(habit: $habit)
        } label: {
            HStack {
                Text(habit.name)
                Spacer()
                Image(systemName: habit.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(habit.completed ? .green : .red)
            }
        }
    }
}

struct HabitDetailView: View {
    @Binding var habit: Habit
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Habit Name", text: $habit.name)
            }
            Section(header: Text("Description")) {
                TextEditor(text: $habit.description)
            }
            Section {
                Toggle(isOn: $habit.completed) {
                    Text("Completed")
                }
            }
        }
    }
}

struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var completed: Bool
}


#Preview {
    HabitTrackingAppTwo() as any View
}

