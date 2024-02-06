import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http_app/app/controllers/pets_controller.dart';
import 'package:http_app/app/models/pets_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final provider = Provider.of<PetsController>(context, listen: false);
    provider.getDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('Build called');
    final provider = Provider.of<PetsController>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Provier API Call'),
      ),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(provider.pets),
    );
  }

  Widget getLoadingUI() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: Color.fromARGB(255, 0, 0, 0),
            size: 50.0,
          ),
          Text("Loading .....")
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI(Pets pets) {
    return ListView.builder(
      itemCount: pets.data.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(pets.data[index].petImage),
          backgroundColor: Colors.white,
        ),
        title: Text(pets.data[index].userName),
        trailing: pets.data[index].isFriendly
            ? const SizedBox()
            : const Icon(
                Icons.pets,
                color: Colors.red,
              ),
      ),
    );
  }
}
