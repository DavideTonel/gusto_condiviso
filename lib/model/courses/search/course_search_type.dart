enum CourseSearchType {
  byCodice("Codice"),
  byName("Nome"),
  byTeacher("Insegnante"),
  byNameAndTeacher("Nome ed insegnante");

  final String name;
  const CourseSearchType(this.name);
}