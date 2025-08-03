import 'package:injectable/injectable.dart';

@injectable
class ArtRepository {
  // Simulate fetching photo URLs from a remote source
  Future<List<String>> fetchArtPhotos() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      'https://avatars.githubusercontent.com/u/58616351?v=4',
      'https://raw.githubusercontent.com/ItsManikantaGopi/ItsManikantaGopi/main/assets/profile.jpg',
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
    ];
  }
}
