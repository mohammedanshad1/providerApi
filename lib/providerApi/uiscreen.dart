import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider_rest_api/providerApi/provider.dart';
import 'package:provider_rest_api/providers/pets_provider.dart';

class   UiPage extends StatefulWidget {
  const UiPage({super.key});

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  @override
  void initState() {
    final provider = Provider.of<ModelsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build called');
    final provider = Provider.of<ModelsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider API Call'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
          ? getErrorUI(provider.error)
          : getBodyUI(),
    );
  }

  Widget getLoadingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 80,
          ),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
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

  Widget getBodyUI() {
    final provider = Provider.of<ModelsProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              provider.search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ModelsProvider modelsProvider, child) =>
                ListView.builder(
                  itemCount: modelsProvider.serachedModels.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                          modelsProvider.serachedModels.data![index].avatar!),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(modelsProvider.serachedModels.data![index].firstName!),

                    subtitle:  Text(modelsProvider.serachedModels.data![index].lastName!),
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
