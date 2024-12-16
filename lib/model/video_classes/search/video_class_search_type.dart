enum VideoClassSearchType {
  byName("Nome"),
  byTeacher("Insegnante"),
  byNameAndTeacher("Nome ed insegnante");

  final String name;
  const VideoClassSearchType(this.name);
}