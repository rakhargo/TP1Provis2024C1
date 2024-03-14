import 'dart:async';
import 'dart:io';

// Kelas untuk film
class Film 
{
  String filmID;
  String title;
  String genre;
  int duration;

  Film(this.filmID, this.title, this.genre, this.duration);
}

// Kelas untuk mewakili tiket bioskop
class Ticket 
{
  String ticketID;
  Film film;
  int price;
  String theatre;
  String seat;

  Ticket(this.ticketID, this.film, this.price, this.theatre, this.seat);

  void printTicketInfo()
  {
    print("ID Tiket : ${ticketID}");
    print("Film     : ${film.title}");
    print("Genre    : ${film.genre}");
    print("Durasi   : ${film.duration} menit");
    print("Teater   : Teater $theatre");
    print("Kursi    : $seat");
    print("Harga    : Rp. $price");
  }
}

// Fungsi untuk meniru pembelian tiket secara asynchronous
Future<Ticket> buyTicket(String ticketID, Film film, String theatre, String seat) async 
{
  
  await Future.delayed(Duration(seconds: 2)); // Menunggu 2 detik 

  // Simulasi harga tiket yang bervariasi berdasarkan film dan bioskop
  int price = film.duration > 130 ? 40000 : 35000; // Jika film lebih dari 130 menit
  price += theatre == "IMAX" ? 20000 : 0; // Jika teater IMAX
  price += seat[0] == "A" ? 5000 : 0; // Jika seatnya adalah A, atau paling belakang (biasanya sweetbox atau sejenisnya)

  return Ticket(ticketID, film, price, theatre, seat);
}

void main() async 
{
  // Film-film yang tersedia
  var films = [
    Film("F01", "Avengers: Endgame", "Action", 181),
    Film("F02", "Joker", "Drama", 122),
    Film("F03", "Inception", "Sci-Fi", 148),
  ];

  // Pembelian tiket
  print("Welcome to N-TIX!");

  print("List film yang tersedia:");
  for (var film in films)
  {
    stdout.write("+"); for (var i = 0; i < film.title.length; i++) stdout.write("-"); stdout.write("+");
    stdout.write("+"); for (var i = 0; i < film.genre.length; i++) stdout.write("-"); stdout.write("+");
    stdout.write("+"); for (var i = 0; i < '${film.duration}'.length + 6; i++) stdout.write("-"); print("+");

    stdout.write("|"); stdout.write(film.title); stdout.write("|");
    stdout.write("|"); stdout.write(film.genre); stdout.write("|");
    stdout.write("|"); stdout.write("${film.duration} menit"); print("|");

    stdout.write("+"); for (var i = 0; i < film.title.length; i++) stdout.write("-"); stdout.write("+");
    stdout.write("+"); for (var i = 0; i < film.genre.length; i++) stdout.write("-"); stdout.write("+");
    stdout.write("+"); for (var i = 0; i < '${film.duration}'.length + 6; i++) stdout.write("-"); print("+");
  }

  // Fungsi mencari film di list film dengan ID nya 
  Film findFilm(String filmID) => films.firstWhere((ele) => ele.filmID == filmID);

  // Anggap seperti masukan user
  var pilih1 = "F01";
  var pilih2 = "F02";
  var pilih3 = "F03";

  print("\nMembeli tiket untuk ${findFilm(pilih1).title}");
  var ticket1 = await buyTicket("T001", findFilm(pilih1), "IMAX", "A-01");
  print("\nTicket berhasil dibeli!\n");
  ticket1.printTicketInfo();
  
  print("\nMembeli tiket untuk ${findFilm(pilih2).title}");
  var ticket2 = await buyTicket("T002", findFilm(pilih2), "2", "A-01");
  print("\nTicket berhasil dibeli!\n");
  ticket2.printTicketInfo();

  print("\nMembeli tiket untuk ${findFilm(pilih3).title}");
  var ticket3 = await buyTicket("T002", findFilm(pilih3), "2", "A-01");
  print("\nTicket berhasil dibeli!\n");
  ticket3.printTicketInfo();

  print("Terima kasih telah menggunakan N-TIX");
}
