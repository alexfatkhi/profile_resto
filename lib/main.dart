import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final biodata = <String, dynamic>{};

  MyApp({super.key}) {
    biodata['name'] = 'RM Sedap Rasa';
    biodata['email'] = 'sedaprasa@example.com';
    biodata['phone'] = '61343242342';
    biodata['image'] = 'assets/Rumah_Makan.jpg';
    biodata['addr'] = 'Jl. Freeway, dekat Moonstad';
    biodata['desc'] =
        '''Rumah Makan Sedap Rasa adalah tempat makan yang dikenal dengan kelezatan masakan tradisionalnya. Mengusung konsep yang hangat dan nyaman, rumah makan ini menawarkan beragam menu khas Nusantara dengan cita rasa autentik.''';
    biodata['menu'] = ['Ayam Goreng', 'Ikan Bakar', 'Sayur Asem', 'Sambal Pedas'];
    biodata['open_hours'] = 'Senin - Jumat: 10:00 - 22:00\nSabtu - Minggu: 09:00 - 23:00';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Resto',
      home: Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                teksKotak(Colors.black, biodata['name'] ?? ''),
                Image(image: AssetImage(biodata["image"] ?? '')),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BtnContact(Icons.email, Colors.green[900],
                        "mailto:${biodata['email']}?subject=Tanya Seputar Resto"),
                    BtnContact(Icons.location_on, Colors.blueAccent,
                        "https://maps.google.com?q=${biodata['addr']}"),
                    BtnContact(Icons.phone, Colors.deepPurple,
                        "tel:${biodata['phone']}")
                  ],
                ),
                const SizedBox(height: 20),
                teksKotak(Colors.black38, 'Deskripsi'),
                const SizedBox(height: 10),
                Text(
                  biodata['desc'] ?? "",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                teksKotak(Colors.black38, 'List Menu'),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (biodata['menu'] as List<String>).length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.restaurant_menu),
                      title: Text(
                        biodata['menu'][index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                textAttribute("Alamat", biodata['addr'] ?? ''),
                const SizedBox(height: 10),
                teksKotak(Colors.black38, 'Jam Buka'),
                const SizedBox(height: 10),
                Text(
                  biodata['open_hours'] ?? "",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }

  Container teksKotak(Color bgColor, String teks) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(color: bgColor),
      child: Text(
        teks,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Row textAttribute(String judul, String teks) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "$judul:",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: Text(
            teks,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Expanded BtnContact(IconData icon, Color? color, String uri) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          launch(uri);
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white)),
        child: Icon(icon),
      ),
    );
  }

  void launch(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Tidak dapat memanggil: $uri');
    }
  }
}
