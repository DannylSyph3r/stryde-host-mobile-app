enum EventType { dropOff, pickUp }

class CarEvent {
  final String carName;
  final EventType eventType;
  final DateTime eventDateTime;
  final String location;

  CarEvent({
    required this.carName,
    required this.eventType,
    required this.eventDateTime,
    required this.location,
  });
}

class EventSet {
  final CarEvent dropOff;
  final CarEvent pickUp;

  EventSet({
    required this.dropOff,
    required this.pickUp,
  });
}

List<EventSet> eventSets = [
  EventSet(
    dropOff: CarEvent(
      carName: "Tesla Model S",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 1, 10, 0),
      location: "Location A",
    ),
    pickUp: CarEvent(
      carName: "Tesla Model S",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 1, 15, 0),
      location: "Location B",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "BMW X5",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 3, 9, 0),
      location: "Location C",
    ),
    pickUp: CarEvent(
      carName: "BMW X5",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 4, 11, 0),
      location: "Location D",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Audi A4",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 5, 13, 0),
      location: "Location E",
    ),
    pickUp: CarEvent(
      carName: "Audi A4",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 6, 12, 0),
      location: "Location F",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Mercedes-Benz C-Class",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 7, 14, 0),
      location: "Location G",
    ),
    pickUp: CarEvent(
      carName: "Mercedes-Benz C-Class",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 9, 16, 0),
      location: "Location H",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Honda Accord",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 8, 10, 0),
      location: "Location I",
    ),
    pickUp: CarEvent(
      carName: "Honda Accord",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 9, 14, 0),
      location: "Location J",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Toyota Camry",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 10, 11, 0),
      location: "Location K",
    ),
    pickUp: CarEvent(
      carName: "Toyota Camry",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 11, 13, 0),
      location: "Location L",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Ford Explorer",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 15, 9, 0),
      location: "Location M",
    ),
    pickUp: CarEvent(
      carName: "Ford Explorer",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 17, 10, 0),
      location: "Location N",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Chevrolet Tahoe",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 18, 8, 0),
      location: "Location O",
    ),
    pickUp: CarEvent(
      carName: "Chevrolet Tahoe",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 20, 9, 0),
      location: "Location P",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Nissan Altima",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 20, 14, 0),
      location: "Location Q",
    ),
    pickUp: CarEvent(
      carName: "Nissan Altima",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 21, 15, 0),
      location: "Location R",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Jeep Grand Cherokee",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 22, 10, 0),
      location: "Location S",
    ),
    pickUp: CarEvent(
      carName: "Jeep Grand Cherokee",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 22, 14, 0),
      location: "Location T",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Volkswagen Passat",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 24, 12, 0),
      location: "Location U",
    ),
    pickUp: CarEvent(
      carName: "Volkswagen Passat",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 25, 10, 0),
      location: "Location V",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Subaru Outback",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 28, 8, 0),
      location: "Location W",
    ),
    pickUp: CarEvent(
      carName: "Subaru Outback",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 28, 14, 0),
      location: "Location X",
    ),
  ),
  // Two event sets on the same day
  EventSet(
    dropOff: CarEvent(
      carName: "Mazda CX-5",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 30, 9, 0),
      location: "Location Y",
    ),
    pickUp: CarEvent(
      carName: "Mazda CX-5",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 30, 14, 0),
      location: "Location Z",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Hyundai Tucson",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 8, 30, 11, 0),
      location: "Location AA",
    ),
    pickUp: CarEvent(
      carName: "Hyundai Tucson",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 8, 30, 16, 0),
      location: "Location BB",
    ),
  ),
  EventSet(
    dropOff: CarEvent(
      carName: "Toyota Camry",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 1, 8, 0),
      location: "Location H",
    ),
    pickUp: CarEvent(
      carName: "Toyota Camry",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 1, 15, 0),
      location: "Location I",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Subaru Outback",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 2, 9, 0),
      location: "Location J",
    ),
    pickUp: CarEvent(
      carName: "Subaru Outback",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 4, 12, 0),
      location: "Location K",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Mazda 3",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 4, 10, 0),
      location: "Location L",
    ),
    pickUp: CarEvent(
      carName: "Mazda 3",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 7, 14, 0),
      location: "Location M",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Kia Forte",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 6, 11, 0),
      location: "Location N",
    ),
    pickUp: CarEvent(
      carName: "Kia Forte",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 9, 16, 0),
      location: "Location O",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Hyundai Sonata",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 8, 9, 30),
      location: "Location P",
    ),
    pickUp: CarEvent(
      carName: "Hyundai Sonata",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 11, 15, 0),
      location: "Location Q",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Jeep Compass",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 10, 12, 0),
      location: "Location R",
    ),
    pickUp: CarEvent(
      carName: "Jeep Compass",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 12, 13, 30),
      location: "Location S",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Chevrolet Cruze",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 13, 10, 0),
      location: "Location T",
    ),
    pickUp: CarEvent(
      carName: "Chevrolet Cruze",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 16, 16, 0),
      location: "Location U",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Ford Escape",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 17, 11, 0),
      location: "Location V",
    ),
    pickUp: CarEvent(
      carName: "Ford Escape",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 19, 10, 30),
      location: "Location W",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Nissan Rogue",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 20, 9, 0),
      location: "Location X",
    ),
    pickUp: CarEvent(
      carName: "Nissan Rogue",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 22, 14, 0),
      location: "Location Y",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Audi A4",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 23, 8, 30),
      location: "Location Z",
    ),
    pickUp: CarEvent(
      carName: "Audi A4",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 26, 16, 0),
      location: "Location A",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "BMW 3 Series",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 25, 10, 0),
      location: "Location B",
    ),
    pickUp: CarEvent(
      carName: "BMW 3 Series",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 27, 14, 0),
      location: "Location C",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Mercedes-Benz C-Class",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 28, 11, 0),
      location: "Location D",
    ),
    pickUp: CarEvent(
      carName: "Mercedes-Benz C-Class",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 28, 16, 0),
      location: "Location E",
    ),
  ),

  EventSet(
    dropOff: CarEvent(
      carName: "Porsche Macan",
      eventType: EventType.dropOff,
      eventDateTime: DateTime(2024, 9, 30, 9, 0),
      location: "Location F",
    ),
    pickUp: CarEvent(
      carName: "Porsche Macan",
      eventType: EventType.pickUp,
      eventDateTime: DateTime(2024, 9, 30, 15, 0),
      location: "Location G",
    ),
  ),
];
