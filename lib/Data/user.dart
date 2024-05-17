class User {
  String id;
  String email;
  String password;

  User({
    required this.id,
    required this.email,
    required this.password,
  });
}

final List<User> sampleUsers = [
  User(id: '1', email: 'jame', password: '1234'),
  User(id: '2', email: 'john', password: '12345'),
];
