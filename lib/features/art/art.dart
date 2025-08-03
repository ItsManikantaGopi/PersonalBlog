import 'package:flutter/material.dart';
import '../../components/titles.dart';
import 'package:provider/provider.dart';
import 'art_repository.dart';

class ArtViewModel extends ChangeNotifier {
  final ArtRepository repository;
  List<String> photos = [];
  bool isLoading = true;

  ArtViewModel(this.repository);

  Future<void> loadPhotos() async {
    isLoading = true;
    notifyListeners();
    photos = await repository.fetchArtPhotos();
    isLoading = false;
    notifyListeners();
  }
}

class Art extends StatelessWidget {
  final Titles titles;
  const Art({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ArtViewModel>(
      create: (_) {
        final model = ArtViewModel(ArtRepository());
        model.loadPhotos();
        return model;
      },
      child: Consumer<ArtViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text(titles.otherTitle),
              backgroundColor: Colors.purple,
            ),
            body: model.isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    itemCount: model.photos.length,
                    itemBuilder: (context, index) {
                      final url = model.photos[index];
                      return Card(
                        elevation: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(url, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
