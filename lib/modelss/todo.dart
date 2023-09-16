class ToDo {
  String id;
  String text;
  bool isDone;

  ToDo({
    required this.id,
    required this.text,
    this.isDone = false,
  });

  static List<ToDo> mocks = [
    ToDo(id: '0', text: 'Go to gym', isDone: true),
    ToDo(id: '1', text: 'Buy products to dinner', isDone: true),
    ToDo(id: '2', text: 'Check Emails'),
    ToDo(id: '3', text: 'Teem meeting'),
    ToDo(id: '4', text: 'Work on mobile app for 2 hours'),
    ToDo(id: '5', text: 'Dinner with family'),
  ];
}
