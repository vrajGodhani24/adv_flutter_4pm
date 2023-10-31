import 'package:adv_flutter_4pm/provider/connectivity_provider.dart';
import 'package:adv_flutter_4pm/provider/web_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: (Provider.of<ConnectivityProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                'Offline')
            ? const Text("You are Offline...")
            : GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                children: Provider.of<WebProvider>(context)
                    .webSites
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('web', arguments: e);
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.blue,
                            child: Text(
                              e.webName,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
