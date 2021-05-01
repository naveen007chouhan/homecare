class User {
  final int id;
  final String name;
  final String imageUrl;
  final bool isOnline;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.isOnline,
  });
}

// YOU - current user
final User currentUser = User(
  id: 0,
  name: 'Nick Fury',
  imageUrl: 'assets/images/nick-fury.jpg',
  isOnline: true,
);

// USERS
final User ironMan = User(
  id: 1,
  name: 'Jack Jonson',
  imageUrl: 'assets/images/ironman.jpeg',
  isOnline: true,
);
final User captainAmerica = User(
  id: 2,
  name: 'Nick Jonson',
  imageUrl: 'assets/images/captain-america.jpg',
  isOnline: true,
);
final User hulk = User(
  id: 3,
  name: 'Mike Williams',
  imageUrl: 'assets/images/hulk.jpg',
  isOnline: false,
);
final User scarletWitch = User(
  id: 4,
  name: 'Jerry Michael',
  imageUrl: 'assets/images/scarlet-witch.jpg',
  isOnline: false,
);
final User spiderMan = User(
  id: 5,
  name: 'Robbert',
  imageUrl: 'assets/images/spiderman.jpg',
  isOnline: true,
);
final User blackWindow = User(
  id: 6,
  name: 'Steve Aoki',
  imageUrl: 'assets/images/black-widow.jpg',
  isOnline: false,
);
final User thor = User(
  id: 7,
  name: 'Calvin Harris',
  imageUrl: 'assets/images/thor.png',
  isOnline: false,
);
final User captainMarvel = User(
  id: 8,
  name: 'Luke David',
  imageUrl: 'assets/images/captain-marvel.jpg',
  isOnline: false,
);