import 'package:eagle_eye/screens/photo_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const DetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  var gallery = [];
  @override
  void initState() {
    gallery = widget.data['gallery'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 60,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Text(
              widget.data['name'],
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black, letterSpacing: 2),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(widget.data['location']),
                const SizedBox(height: 10),
                Text(widget.data['short_description']),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: gallery.map((e) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PhotoViewScreen(photo: e)));
                  },
                  child: Card(
                    child: Image(
                      image: NetworkImage(e),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(widget.data['description']),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            MapsLauncher.launchQuery(widget.data['name']);
          },
          child: const Icon(Icons.not_listed_location_sharp),
        ),
      ),
    );
  }
}
