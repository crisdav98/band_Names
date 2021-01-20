class Band {
  String id;
  String name;
  int votes;

  Band({this.id, this.name, this.votes});

  // El factory constructor no es mas que un constructor  que recibe  ciertos tipo de elementos y devuelve una instancia de la clase
  factory Band.fromMap(Map<String, dynamic> obj) => Band(
        id: obj['id'],
        name: obj['name'],
        votes: obj['votes '],
      );
}
