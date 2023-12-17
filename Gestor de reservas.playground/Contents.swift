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
    func addReservation(clients clientList: [Client],days: UInt,breakfast: Bool) {
        var price: Float
        var basePrice: Int = 20
        var breakfastMultiplier: Float = 1
        
        // Control de errores
        do {
            try validateIdMatch(id: reservation.id)
            do {
                try validateName(clients: clientList)
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
                print("Reservation added correctly\n---------------------------")
                prettyShow(reservation)
                
                reservation.idSum()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    // Método para eliminar reservas de la lista
    func removeReservation(id: UInt) {
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
            print("Showing current reservations\n----------------------------")
            for reservation in reservationList {
                prettyShow(reservation)
            }
            return reservationList
        } else {
            print("No hay reservas.")
            return reservationList
        }
    }

    // MARK: Métodos para control de errores
    // No se hacen privados para poder tener acceso en los tests
    func validateIdMatch(id: UInt) throws {
        for reservation in reservationList {
            if id == reservation.id {
                throw ReservationError.idMatch
            }
        }
    }

    func validateName(clients clientList: [Client]) throws {
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
    
    func validateReservationId(_ reservationId: UInt) throws {
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
    
    func prettyShow(_ reservation: Reservation) {
        print("Hotel name: \(reservation.nameHotel)")
        print("Reservation ID: \(reservation.id)")
        print("Number of clients: \(reservation.clientList.count)")
        for client in reservation.clientList {
            print("- Name: \(client.name)\t Age: \(client.age)\t Height: \(client.height)")
        }
        print("Number of days: \(reservation.days)")
        if(reservation.breakfast == true) {
            print("Breakfast: Yes")
        } else {
            print("Breakfast: No")
        }
        print("Price: \(reservation.price)")
        print()
    }
}

// MARK: Declaración de clase con la batería de tests
class ValidateTests {
    // Se crean los objetos que se usarán en los tests
    private let goku: Client = Client(name: "Goku", age: 42, height: 1.9)
    private let krilin: Client = Client(name: "Krilin", age: 36, height: 1.5)
    private let vegeta: Client = Client(name: "Vegeta", age: 39, height: 1.7)
    private let bulma: Client = Client(name: "Bulma", age: 32, height: 1.6)
    
    func testAddReservation() {
        // Se testea si salta error en una reserva con un ID ya existente
        
        do {
            let manager: HotelReservationManager = HotelReservationManager()
            manager.addReservation(clients: [goku, krilin], days: 2, breakfast: true)
            try manager.validateIdMatch(id: 1)
            assertionFailure("Fallo en la validación de IDs")
        } catch {
            let validationError = error as? ReservationError
            assert(validationError != nil)
            assert(validationError == ReservationError.idMatch)
        }
        
        // Se testea si salta error en una reserva con un nombre ya existente
        do {
            let manager: HotelReservationManager = HotelReservationManager()
            manager.addReservation(clients: [goku, krilin], days: 2, breakfast: false)
            try manager.validateName(clients: [vegeta, bulma, krilin])
            assertionFailure("Fallo en la validación de nombres")
        } catch {
            let validationError = error as? ReservationError
            assert(validationError != nil)
            assert(validationError == ReservationError.clientMatch)
        }
    }
    
    func testCancelReservation() {
        let manager: HotelReservationManager = HotelReservationManager()
        manager.addReservation(clients: [goku, krilin], days: 2, breakfast: true)
        manager.addReservation(clients: [vegeta, bulma], days: 1, breakfast: false)
        // Se testea que al eliminar una reserva ésta se borra correctamente de la lista
        manager.removeReservation(id: 1)
        let reservationList: [Reservation] = manager.showReservationList
        assert(reservationList.count == 1)
        assert(reservationList[0].id == 2)
        // Se testea que salta un error al intentar borrar una reserva con un ID inexistente
        do {
            try manager.validateReservationId(3)
            assertionFailure("Fallo en borrado de reservas con ID inexistente")
        } catch {
            let validationError = error as? ReservationError
            assert(validationError != nil)
            assert(validationError == ReservationError.noReservation)
        }
    }
    
    func testReservationPrice() {
        let manager: HotelReservationManager = HotelReservationManager()
        manager.addReservation(clients: [goku, krilin], days: 2, breakfast: true)
        manager.addReservation(clients: [vegeta, bulma], days: 2, breakfast: true)
        // Se testea el cálculo correcto de los precios
        var reservationList: [Reservation] = manager.showReservationList
        assert(reservationList[0].price == reservationList[1].price)
        manager.removeReservation(id: 1)
        manager.removeReservation(id: 2)
        manager.addReservation(clients: [goku, krilin], days: 1, breakfast: false)
        manager.addReservation(clients: [vegeta, bulma], days: 1, breakfast: false)
        reservationList = manager.showReservationList
        assert(reservationList[0].price == reservationList[1].price)
    }
}

let tests = ValidateTests()
tests.testAddReservation()
tests.testCancelReservation()
tests.testReservationPrice()
