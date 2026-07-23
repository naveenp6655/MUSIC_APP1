class SongModel {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String audioPath;
  final String imagePath;
  final Duration duration;
  final String category;
  bool isFavorite;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.audioPath,
    required this.imagePath,
    required this.duration,
    required this.category,
    this.isFavorite = false,
  });

  SongModel copyWith({bool? isFavorite}) {
    return SongModel(
      id: id,
      title: title,
      artist: artist,
      album: album,
      audioPath: audioPath,
      imagePath: imagePath,
      duration: duration,
      category: category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

final List<SongModel> sampleSongs = [
  SongModel(
    id: "1",
    title: "Azhage Azhage",
    artist: "Deva Hits",
    album: "Tamil Classics",
    audioPath: "sounds/Azhage Azhage.mp3",
    imagePath: "assets/image/deva.png",
    duration: const Duration(minutes: 4, seconds: 15),
    category: "Deva Magic",
  ),
  SongModel(
    id: "2",
    title: "Inji Idupazhagi",
    artist: "Ilaiyaraaja & Janaki",
    album: "Devar Magan",
    audioPath: "sounds/Inji Idupazhagi.mp3",
    imagePath: "assets/image/raja.png",
    duration: const Duration(minutes: 3, seconds: 40),
    category: "Ilaiyaraaja Hits",
    isFavorite: true,
  ),
  SongModel(
    id: "3",
    title: "Muthumani Malai",
    artist: "Ilaiyaraaja & SPB",
    album: "Chinna Gounder",
    audioPath: "sounds/Muthumani Malai.mp3",
    imagePath: "assets/image/raja.png",
    duration: const Duration(minutes: 5, seconds: 10),
    category: "Ilaiyaraaja Hits",
  ),
  SongModel(
    id: "4",
    title: "Nadhiyae (Theemthanana)",
    artist: "Unni Menon",
    album: "Rhythm",
    audioPath: "sounds/Nadhiyae (Theemthanana).mp3",
    imagePath: "assets/image/deva.png",
    duration: const Duration(minutes: 5, seconds: 45),
    category: "90s Classics",
  ),
  SongModel(
    id: "5",
    title: "Nilaave Vaa",
    artist: "SPB & Ilaiyaraaja",
    album: "Mouna Ragam",
    audioPath: "sounds/Nilaave Vaa.mp3",
    imagePath: "assets/image/raja.png",
    duration: const Duration(minutes: 4, seconds: 35),
    category: "Ilaiyaraaja Hits",
    isFavorite: true,
  ),
  SongModel(
    id: "6",
    title: "Para Para",
    artist: "Chinmayi & Javed Ali",
    album: "Neerparavai",
    audioPath: "sounds/Para Para.mp3",
    imagePath: "assets/image/deva.png",
    duration: const Duration(minutes: 4, seconds: 50),
    category: "Melodies",
  ),
  SongModel(
    id: "7",
    title: "Pottu Vaitha Oru Vatta Nila",
    artist: "KJ Yesudas",
    album: "Idhayam",
    audioPath: "sounds/Pottu Vaitha Oru Vatta Nila.mp3",
    imagePath: "assets/image/raja.png",
    duration: const Duration(minutes: 4, seconds: 20),
    category: "Ilaiyaraaja Hits",
  ),
  SongModel(
    id: "8",
    title: "Raja Raja Chozhan",
    artist: "KJ Yesudas",
    album: "Agni Natchathiram",
    audioPath: "sounds/Raja Raja Chozhan.mp3",
    imagePath: "assets/image/raja.png",
    duration: const Duration(minutes: 4, seconds: 30),
    category: "Ilaiyaraaja Hits",
    isFavorite: true,
  ),
  SongModel(
    id: "9",
    title: "Sollitaley Ava Kaadhala",
    artist: "V.V. Prasanna",
    album: "Kumki",
    audioPath: "sounds/Sollitaley Ava Kaadhala.mp3",
    imagePath: "assets/image/deva.png",
    duration: const Duration(minutes: 4, seconds: 40),
    category: "Melodies",
  ),
  SongModel(
    id: "10",
    title: "Sundari Kannal",
    artist: "SPB & S. Janaki",
    album: "Thalapathi",
    audioPath: "sounds/Sundari Kannal.mp3",
    imagePath: "assets/image/raja.png",
    duration: const Duration(minutes: 6, seconds: 15),
    category: "Ilaiyaraaja Hits",
    isFavorite: true,
  ),
  SongModel(
    id: "11",
    title: "Veesum Velichathile",
    artist: "Karthik",
    album: "Naan Ee",
    audioPath: "sounds/Veesum Velichathile.mp3",
    imagePath: "assets/image/deva.png",
    duration: const Duration(minutes: 3, seconds: 15),
    category: "Melodies",
  ),
];
