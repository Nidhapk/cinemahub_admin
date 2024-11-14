import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:onlinebooking_adminside/data/modals/caste_model.dart';
import 'package:onlinebooking_adminside/data/modals/movie_model.dart';

class MovieDatabaserepository {
  final CollectionReference movieCollection =
      FirebaseFirestore.instance.collection('movies');
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<void> addMovieDetails(MovieClass movie) async {
    try {
      final refDoc = await movieCollection.add(movie.toMap());
      String movieId = refDoc.id;
      refDoc.update({'movieId': movieId});
    } on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<MovieClass> getMovies(String movieId) async {
    try {
      final movies = await movieCollection.doc(movieId).get();
      if (movies.exists) {
        return MovieClass.fromJson(movies.data() as Map<String,dynamic>);
      } else {
        throw Exception("Movie not found");
      }
    } on FirebaseException catch (_) {
     // print('Error fetching movie: $e');
      rethrow;
    }
  }

  Future<List<MovieClass>> getAllMovies() async {
    try {
      final snapshot = await movieCollection.get();

      // Check if there are any documents in the collection
      // if (snapshot.docs.isEmpty) {
      //   throw Exception("No movies found");
      // }

      // Convert the list of documents to a list of MovieClass instances
      final List<MovieClass> movies = snapshot.docs.map((doc) {
        return MovieClass.fromJson(doc.data() as Map<String,dynamic>);
      }).toList();

      return movies;
    } on FirebaseException catch (_) {
     // print('Error fetching movies: $e');
      rethrow;
    }
  }

  Future<void> updateMovie({
    required String movieId,
    required bool blocked,
    required String trailerLink,
    required String movieName,
    required String certificate,
    required List<String> languages,
    required List<String> genres,
    required String releaseDate,
    required String duration,
    required String description,
    required List<CastMember> castMembers,
    required String posterImage,
    required String backdropImage,
  }) async {
    try {
      await movieCollection.doc(movieId).update(
        {
          'trailerLink': trailerLink,
          'blocked': blocked,
          'movieName': movieName,
          'certificate': certificate,
          'languages': languages,
          'genres': genres,
          'releaseDate': releaseDate,
          'duration': duration,
          'description': description,
          'castMembers': castMembers.map((cast) => cast.toMap()).toList(),
          'posterImage': posterImage,
          'backdropImage': backdropImage,
        
        },
      );
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> deleteMovie(String movieId) async {
    try {
      await movieCollection
          .doc(movieId)
          .delete(); // Perform the delete operation

    //  print("Document with ID: $movieId deleted successfully.");
    } catch (e) {
     // print("Error deleting document: $e");
    }
  }
  // Future<String> uploadTrailerUrl(String videoUrl) async {
  //   Reference ref = firebaseStorage.ref().child('videos/${DateTime.now().millisecondsSinceEpoch.toString()}');
  //   await ref.putFile(File(videoUrl));
  //   String downloadUrl = await ref.getDownloadURL();
  //   return downloadUrl;
  // }

  Future<String> uploadPoster(String? selectedPoster) async {
    if (selectedPoster != null) {
      String imgUrl = '';
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference refDirectory =
            FirebaseStorage.instance.ref().child('posters');
        Reference refImageToUpload = refDirectory.child(fileName);
        await refImageToUpload.putFile(File(selectedPoster));
        imgUrl = await refImageToUpload.getDownloadURL();
      } catch (e) {
        rethrow;
      }
      return imgUrl;
    }
    return '';
  }

  Future<String> uploadBackdrp(String? selectedBackdrop) async {
    String imgUrl = '';
    if (selectedBackdrop != null) {
      try {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference refDirectory =
            FirebaseStorage.instance.ref().child('backdrops');
        Reference refImageToUpload = refDirectory.child(fileName);
        await refImageToUpload.putFile(File(selectedBackdrop));
        imgUrl = await refImageToUpload.getDownloadURL();
      } catch (e) {
        rethrow;
      }
    }
    return imgUrl;
  }

  Future<void> addLanguage(String language) async {
    final docRef = await FirebaseFirestore.instance
        .collection('languages')
        .add({'language': language});
    String id = docRef.id;
    await docRef.update({'languageId': id});
  }

  Future<void> deleteLanguage(String id) async {
    try {
      await FirebaseFirestore.instance.collection('languages').doc(id).delete();
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<void> editLanguage(String id, String language) async {
    try {
      await FirebaseFirestore.instance
          .collection('languages')
          .doc(id)
          .update({'language': language});
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<Language>> fetchLanguages() async {
    try {
      final data =
          await FirebaseFirestore.instance.collection('languages').get();
      List<Language> languages = data.docs.map((doc) {
        return Language(
          id: doc.id,
          language: doc['language'] as String,
        );
      }).toList();
      return languages;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}

class Language {
  final String id;
  final String language;

  Language({required this.id, required this.language});
}
