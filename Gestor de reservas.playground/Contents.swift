import Foundation

// MARK: Declaración de estructuras
struct Client: Equatable {
    let name: String
    let age: UInt
    let height: Float
}

struct Reservation {
    let nameHotel: String = "Fighters Hotel"
    var id: UInt = 1
    var clientList: [Client] = []
    var days: UInt = 0
    var price: Float = 0
    var breakfast: Bool = false
    
    mutating func idSum() {
        self.id += 1
    }
}

// MARK: Declaración de enumerado para control de errores
enum ReservationError: Error {
    case idMatch
    case clientMatch
    case noReservation
}

// MARK: Declaración de clase, en este caso la principal
class HotelReservationManager {
    // Declaración de instancias
    private var reservationList: [Reservation] = []
    private var reservation: Reservation = Reservation()
    
    // Método para añadir reservas, validando antes que no hayan coincidencias con nombres de clientes ya reservados o reservas con mismo ID
    func addReservation(_ clientList: [Client],_ days: UInt,_ breakfast: Bool) {
        var price: Float
        var basePrice: Int = 20
        var breakfastMultiplier: Float = 1
        
        // Control de errores
        do {
            try validateIdMatch(reservation.id)
            do {
                try validateName(clientList)
                if(breakfast) {
                    breakfastMultiplier = 1.25
                }
                
                // Se calcula el precio según el enunciado del ejercicio: nº clientes * precio base * nº días * 1,25 si hay desayuno
                price = Float(clientList.count) * Float(basePrice) * Float(days) * breakfastMultiplier
                
                // Se modifican los datos del objeto reservation, se añade la reserva a la lista, devuelve reserva y se cambia la ID
                reservation.breakfast = breakfast
                reservation.clientList = clientList
                reservation.days = days
                reservation.price = price
                
                reservationList.append((reservation))
                print(reservation)
                
                reservation.idSum()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    // Método para eliminar reservas de la lista
    func removeReservation(_ id: UInt) {
        // Control de errores
        do {
            try validateReservationId(id)
            var reservationListPosition: Int = 0
            
            for reserv in reservationList {
                if(reserv.id == id) {
                    reservationList.remove(at: reservationListPosition)
                }
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: Propiedad computada para mostrar por pantalla las reservas hechas, si no hay, se informa de ello
    var showReservationList: [Reservation] {
        if(reservationList.count > 0) {
            print(reservationList)
            return reservationList
        } else {
            print("No hay reservas.")
            return reservationList
        }
    }

    // MARK: Métodos para control de errores
    private func validateIdMatch(_ id: UInt) throws {
        for reservation in reservationList {
            if id == reservation.id {
                throw ReservationError.idMatch
            }
        }
    }

    private func validateName(_ clientList: [Client]) throws {
        for client in clientList {
            for reservation in reservationList {
                for clientHosted in reservation.clientList {
                    if(client.name == clientHosted.name) {
                        throw ReservationError.clientMatch
                    }
                }
            }
        }
    }
    
    private func validateReservationId(_ reservationId: UInt) throws {
        var reservationListPosition: Int = 0
        var match: Bool = false
        
        for reservation in reservationList {
            if(reservation.id == reservationId) {
                match = true
                break
            }
            reservationListPosition += 1
        }
        if(!match) {
            throw ReservationError.noReservation
        }
    }
}

let manager: HotelReservationManager = HotelReservationManager()
let goku: Client = Client(name: "Goku", age: 42, height: 1.9)
let krilin: Client = Client(name: "Krilin", age: 36, height: 1.5)
let vegeta: Client = Client(name: "Vegeta", age: 39, height: 1.7)
let bulma: Client = Client(name: "Bulma", age: 32, height: 1.6)

manager.addReservation([goku, krilin], 2, true)
manager.addReservation([vegeta, bulma], 1, false)

manager.removeReservation(1)

manager.addReservation([goku, krilin], 2, true)

manager.showReservationList

manager.removeReservation(2)
manager.removeReservation(3)

manager.showReservationList

func testAddReservation() {

}

func testCancelReservation() {
    
}

func testReservationPrice() {
    
}

