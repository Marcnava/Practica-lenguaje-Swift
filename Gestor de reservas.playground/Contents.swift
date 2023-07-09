import Foundation

struct Client: Equatable {
    
    let name: String
    let age: UInt
    let height: Float
    
}

struct Reservation {
    
    var id: UInt = 1
    var nameHotel: String = "Fabulous Hotel"
    var clientList: [Client] = []
    var days: UInt = 0
    var price: Float = 0
    var breakfast: Bool = false
    
    mutating func idSum() {
        self.id += 1
    }
    
}

enum ReservationError: Error {
    
    case idMatch
    case clientMatch
    case noReservation
    
}

class HotelReservationManager {
    
    var reservationList: [Reservation] = []
    var reservation: Reservation? = nil
    
    init(reservationList: [Reservation], reservation: Reservation) {
        self.reservationList = reservationList
        self.reservation = Reservation()
    }
    
    func addReservation(_ clientList: [Client],_ days: UInt,_ breakfast: Bool) {
        
        var price: Float
        var breakfastMultiplier: Float = 1
        
        if(breakfast) {
            breakfastMultiplier = 1.25
        }
        
        price = Float(clientList.count) * Float(20) * Float(days) * breakfastMultiplier
        reservation?.breakfast = breakfast
        reservation?.clientList = clientList
        reservation?.days = days
        reservation?.price = price
        
        reservationList.append((reservation)!)
        
        reservation?.idSum()
        
    }
    
    func removeReservation(_ id: UInt) {
        
        var count: Int = 0
        for reserv in reservationList {
            if(reserv.id == id) {
                reservationList.remove(at: count)
                break
            }
            count += 1
        }
        
    }
    
    func showReservationList(_ reservationList: [Reservation]) {
        if(reservationList.count > 0) {
            for reservation in reservationList {
                print(reservation)
            }
        } else {
            print("No hay reservas.")
        }
    }
}


func testAddReservation() {
    
    var reservation = Reservation()
    let goku = Client(name: "Goku", age: 41, height: 1.9)
    let krilin = Client(name: "Krilin", age: 36, height: 1.6)
    HotelReservationManager(reservationList: [], reservation: reservation).addReservation([goku, krilin], 2, true)
    
    assert HotelReservationManager().reservationList.count == 1
    
}

func testCancelReservation() {
    
}

func testReservationPrice() {
    
}

