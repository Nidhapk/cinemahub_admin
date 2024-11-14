import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlinebooking_adminside/data/modals/theatre_model.dart';

class TheatreRepository {
  final theatreCollection = FirebaseFirestore.instance.collection('theatres');

  Future<List<TheatreModel>> fetchTheatres() async {
    try {
      final snapshot = await theatreCollection.get();
      List<TheatreModel> theatres = snapshot.docs.map((doc) {
        return TheatreModel.fromMap(doc.data());
      }).toList();
      return theatres;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
