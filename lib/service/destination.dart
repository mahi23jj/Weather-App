class Destination{
  final String name;
  final String temp;

   
Destination({required this.name, required this.temp});

    String get imageUrl => "assets/images/${name.toLowerCase()}.jpg";
}

class alldestination {
  static List<Destination> data
=[
    Destination(name: "Paris", temp: "20"),
    Destination(name: "London", temp: "18"),
    Destination(name: "Tokyo", temp: "25"),
    Destination(name: "Ethiopia", temp: "22"),
    Destination(name: "Dubai", temp: "30"),
]  ;
}