
class Comment {
  final int id;
  final String username,text, date;



  Comment({
    required this.id,
    required this.username,
    required this.text,
    required this.date
  });
}

// Our demo Comments

List<Comment> demoComments = [
  Comment(
    id: 1,
    text: 'amazing place',
    username: "Mostafa Abo Rapie",
    date: "march 14th, 2022",
  ),
  Comment(
    id: 2,
    text: 'wonderful place',
    username: "Nasr Kamel",
    date: "march 20th, 2022",

  ),
  Comment(
    id: 3,
    text: 'good place',
    username: "Eslam",
    date: "march 20th, 2022",

  ),
  Comment(
    id: 4,
    text: 'wonderful place',
    username: "Medhat",
    date: "july 20th, 2022",
  ),
  Comment(
    id: 5,
    text: 'amazing place',
    username: "Mokhtar Mostafa",
    date: "march 14th, 2022",
  ),
  Comment(
    id: 6,
    text: 'wonderful place',
    username: "Amal",
    date: "march 20th, 2022",

  ),
  Comment(
    id: 7,
    text: 'good place',
    username: "Hnd sayed",
    date: "march 20th, 2022",

  ),
  Comment(
    id: 8,
    text: 'wonderful place',
    username: "Mohamed ahmed metwaly",
    date: "july 20th, 2022",
  ),
];



