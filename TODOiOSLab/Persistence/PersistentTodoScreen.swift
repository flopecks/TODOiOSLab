import SwiftUI
import SwiftData

// Selector preparado: cada caso tiene identidad estable para el Picker.
enum TodoFilter: String, CaseIterable, Identifiable {
    case all = "Todas"
    case pending = "Pendientes"
    case completed = "Completadas"
    var id: Self { self }
}

// Laboratorio de persistencia y filtros.
struct PersistentTodoScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \StoredTodo.createdAt) private var todos: [StoredTodo]
    @State private var newTodoText = ""
    @State private var selectedFilter: TodoFilter = .all
    @State private var errorMessage: String?

    private var remainingCount: Int {
        todos.filter { !$0.isDone }.count
    }

    private var visibleTodos: [StoredTodo] {
        switch selectedFilter {
        case .all:
            return todos
        case .pending:
            // DATOS 4A: devuelve solo las tareas pendientes.
            return todos
        case .completed:
            // DATOS 4B: devuelve solo las tareas completadas.
            return todos
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    LabHeader(remainingCount: remainingCount, totalCount: todos.count,
                              storageLabel: "SwiftData · almacenamiento local")
                }
                Section("Nueva tarea") {
                    HStack {
                        TextField("¿Qué quieres hacer?", text: $newTodoText)
                            .accessibilityIdentifier("newTodoField")
                            .submitLabel(.done)
                            .onSubmit { addTodo() }
                        Button(action: addTodo) {
                            Image(systemName: "plus.circle.fill").font(.title2)
                        }
                        .accessibilityLabel("Agregar tarea")
                        .accessibilityIdentifier("addTodoButton")
                        .disabled(newTodoText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .buttonStyle(.borderless)
                    }
                }
                Section("Mostrar") {
                    Picker("Estado", selection: $selectedFilter) {
                        ForEach(TodoFilter.allCases) { filter in
                            Text(filter.rawValue).tag(filter)
                        }
                    }
                    .pickerStyle(.segmented)
                    .accessibilityIdentifier("filterPicker")
                    Text("Mostrando \(visibleTodos.count) de \(todos.count) tareas")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .accessibilityIdentifier("visibleCountLabel")
                }
                Section("Mis tareas") {
                    if todos.isEmpty {
                        ContentUnavailableView("Comienza tu lista persistente",
                                               systemImage: "externaldrive",
                                               description: Text("Las tareas de la práctica en memoria no se copian aquí."))
                    } else if visibleTodos.isEmpty {
                        ContentUnavailableView("No hay tareas en este filtro",
                                               systemImage: "line.3.horizontal.decrease.circle",
                                               description: Text("Elige Todas para ver tu lista completa."))
                    }
                    ForEach(visibleTodos) { todo in
                        TodoRow(title: todo.title, isDone: todo.isDone,
                                onToggle: {
                                    todo.isDone.toggle()
                                    saveChanges()
                                },
                                onDelete: { deleteTodo(todo) })
                    }
                }
            }
            .navigationTitle("Mis tareas")
            .alert("No se pudo guardar", isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            )) {
                Button("Entendido", role: .cancel) { errorMessage = nil }
            } message: {
                Text(errorMessage ?? "Intenta nuevamente.")
            }
        }
    }

    private func addTodo() {
        let title = newTodoText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !title.isEmpty else { return }
        // DATOS 2: inserta un StoredTodo en modelContext (una línea).
        if saveChanges() { newTodoText = "" }
    }

    private func deleteTodo(_ todo: StoredTodo) {
        // DATOS 3: elimina todo de modelContext (una línea).
        saveChanges()
    }

    @discardableResult
    private func saveChanges() -> Bool {
        do {
            try modelContext.save()
            return true
        } catch {
            modelContext.rollback()
            errorMessage = "No se guardaron los cambios. Intenta de nuevo. \(error.localizedDescription)"
            return false
        }
    }
}

#Preview {
    PersistentTodoScreen()
        .modelContainer(for: StoredTodo.self, inMemory: true)
}
