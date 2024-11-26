class Teacher {
  final String username;
  final String password;
  final String name;
  final String surname;
  final String mail;
  final String birthday; // YYYY-MM-DD

  final String description;

  Teacher(
    {
      required this.username,
      required this.password,
      required this.name,
      required this.surname,
      required this.mail,
      required this.birthday,
      required this.description
    }
  );
}