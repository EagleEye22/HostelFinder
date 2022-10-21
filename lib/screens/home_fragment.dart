import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eagle_eye/screens/details_screen.dart';
import 'package:flutter/material.dart';

import '../model/hostels.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  HomeFragmentState createState() => HomeFragmentState();
}

class HomeFragmentState extends State<HomeFragment> {
  late Stream<List<Hostels>> hostelstream;
  String? name;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('hostels').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Find Available Hostels"),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.count(
              crossAxisCount: 2,
              children: snapshot.data!.docs.map((document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  data: data,
                                )));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          width: 180,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(data['cover_image']))),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Text(
                            data['name'],
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Text(data['location']),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
            // ignore: dead_code
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  onTap: () {
//            Navigator.pop(context);
                  },
                  leading: Image.network(
                    data['cover_image'],
                    width: 80,
                    height: 80,
                  ),
                  title: Text(data['name']),
                  subtitle: Text(data['location']),
                );
              }).toList(),
            );
          },
        ));
  }
}
