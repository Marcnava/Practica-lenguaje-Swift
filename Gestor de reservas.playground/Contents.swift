import Foundation

struct Client {
    
    let name: String
    let age: UInt
    let height: Float
    
}

struct Reservation {
    
    let id: UInt = 1
    let nameHotel: String = "Fabulous Hotel"
    let clientList: [String]
    let days: UInt
    let price: Decimal
    let breakfast: Bool
    
}

enum ReservationError: Error {
    
    case idMatch
    case clientMatch
    case noReservation
    
}

class HotelReservationManager {
    
    var reservationList: [Reservation]
    
    init(reservationList: [Reservation]) {
        self.reservationList = reservationList
    }
    
    func addReservation(_ clientList: [String],_ days: UInt,_ breakfast: Bool) {
        
    }
    
    func removeReservation(_ id: UInt) {
        
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
    
}

func testCancelReservation() {
    
}

func testReservationPrice() {
    
}
