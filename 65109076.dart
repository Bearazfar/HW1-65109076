import 'dart:io';

enum RoomType { Single, Double, Suite }

class Room {
  String roomNumber;
  RoomType roomType;
  double price;
  bool isBooked;

  Room(this.roomNumber, this.roomType, this.price, {this.isBooked = false});

  void bookRoom() {
    isBooked = true;
  }

  void cancelBooking() {
    isBooked = false;
  }
}

class Guest {
  String name;
  String guestId;
  List<Room> bookedRooms = [];

  Guest(this.name, this.guestId);

  void bookRoom(Room room) {
    if (!room.isBooked) {
      room.bookRoom();
      bookedRooms.add(room);
    } else {
      print('Room ${room.roomNumber} is already booked.');
    }
  }

  void cancelRoom(Room room) {
    if (room.isBooked && bookedRooms.contains(room)) {
      room.cancelBooking();
      bookedRooms.remove(room);
    } else {
      print('Room ${room.roomNumber} is not booked by this guest.');
    }
  }
}

class Hotel {
  List<Room> rooms = [];
  List<Guest> guests = [];

  void addRoom(Room room) {
    rooms.add(room);
    print('Room ${room.roomNumber} added.');
  }

  void removeRoom(String roomNumber) {
    rooms.removeWhere((room) => room.roomNumber == roomNumber);
    print('Room $roomNumber removed.');
  }

  void registerGuest(Guest guest) {
    guests.add(guest);
    print('Guest ${guest.name} registered.');
  }

  void bookRoom(String guestId, String roomNumber) {
    Guest? guest = guests.firstWhere((g) => g.guestId == guestId
    );
    Room? room = rooms.firstWhere((r) => r.roomNumber == roomNumber
    );

    if (guest != null && room != null) {
      guest.bookRoom(room);
      print('Room $roomNumber booked for guest ${guest.name}.');
    } else {
      print('Guest or Room not found.');
    }
  }

  void cancelRoom(String guestId, String roomNumber) {
    Guest? guest = guests.firstWhere((g) => g.guestId == guestId
    );
    Room? room = rooms.firstWhere((r) => r.roomNumber == roomNumber
    );

    if (guest != null && room != null) {
      guest.cancelRoom(room);
      print('Room $roomNumber booking canceled for guest ${guest.name}.');
    } else {
      print('Guest or Room not found.');
    }
  }

  Room? getRoom(String roomNumber) {
    return rooms.firstWhere((r) => r.roomNumber == roomNumber
    );
  }

  Guest? getGuest(String guestId) {
    return guests.firstWhere((g) => g.guestId == guestId
    );
  }
}

void main() {
  Hotel hotel = Hotel();

  while (true) {
    print('------------------------');
    print('Hotel Management System:');
    print('1. Add Room');
    print('2. Remove Room');
    print('3. Register Guest');
    print('4. Book Room');
    print('5. Cancel Room');
    print('6. Get Room');
    print('7. Get Guest');
    print('8. Exit');

    String? input = stdin.readLineSync();
    if (input == null) {
      print('Invalid input. Please enter a number between 1 and 8.');
      continue;
    }
    
    int? choice = int.tryParse(input);

    if (choice == null) {
      print('Invalid input. Please enter a number between 1 and 8.');
      continue;
    }

    switch (choice) {
      case 1:
        print('Enter room number:');
        String? roomNumber = stdin.readLineSync();
        if (roomNumber == null) {
          print('Room number cannot be null.');
          break;
        }
        print('Enter room type (0: Single, 1: Double, 2: Suite):');
        String? roomTypeInput = stdin.readLineSync();
        if (roomTypeInput == null || int.tryParse(roomTypeInput) == null) {
          print('Invalid room type.');
          break;
        }
        RoomType roomType = RoomType.values[int.parse(roomTypeInput)];
        print('Enter room price:');
        String? priceInput = stdin.readLineSync();
        if (priceInput == null || double.tryParse(priceInput) == null) {
          print('Invalid price.');
          break;
        }
        double price = double.parse(priceInput);
        hotel.addRoom(Room(roomNumber, roomType, price));
        break;
      case 2:
        print('Enter room number to remove:');
        String? roomNumber = stdin.readLineSync();
        if (roomNumber == null) {
          print('Room number cannot be null.');
          break;
        }
        hotel.removeRoom(roomNumber);
        break;
      case 3:
        print('Enter guest name:');
        String? name = stdin.readLineSync();
        if (name == null) {
          print('Guest name cannot be null.');
          break;
        }
        print('Enter guest ID:');
        String? guestId = stdin.readLineSync();
        if (guestId == null) {
          print('Guest ID cannot be null.');
          break;
        }
        hotel.registerGuest(Guest(name, guestId));
        break;
      case 4:
        print('Enter guest ID:');
        String? guestId = stdin.readLineSync();
        if (guestId == null) {
          print('Guest ID cannot be null.');
          break;
        }
        print('Enter room number to book:');
        String? roomNumber = stdin.readLineSync();
        if (roomNumber == null) {
          print('Room number cannot be null.');
          break;
        }
        hotel.bookRoom(guestId, roomNumber);
        break;
      case 5:
        print('Enter guest ID:');
        String? guestId = stdin.readLineSync();
        if (guestId == null) {
          print('Guest ID cannot be null.');
          break;
        }
        print('Enter room number to cancel booking:');
        String? roomNumber = stdin.readLineSync();
        if (roomNumber == null) {
          print('Room number cannot be null.');
          break;
        }
        hotel.cancelRoom(guestId, roomNumber);
        break;
      case 6:
        print('Enter room number:');
        String? roomNumber = stdin.readLineSync();
        if (roomNumber == null) {
          print('Room number cannot be null.');
          break;
        }
        Room? room = hotel.getRoom(roomNumber);
        if (room != null) {
          print('Room ${room.roomNumber}, Type: ${room.roomType}, Price: ${room.price}, Booked: ${room.isBooked}');
        } else {
          print('Room not found.');
        }
        break;
      case 7:
        print('Enter guest ID:');
        String? guestId = stdin.readLineSync();
        if (guestId == null) {
          print('Guest ID cannot be null.');
          break;
        }
        Guest? guest = hotel.getGuest(guestId);
        if (guest != null) {
          print('Guest ${guest.name}, ID: ${guest.guestId}, Booked Rooms: ${guest.bookedRooms.map((r) => r.roomNumber).join(', ')}');
        } else {
          print('Guest not found.');
        }
        break;
      case 8:
        return;
      default:
        print('Invalid choice, please try again.');
        break;
    }
  }
}
