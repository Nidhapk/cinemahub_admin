import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_adminside/data/repository/movie_database_repository.dart';
import 'package:onlinebooking_adminside/firebase_options.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/add_movies.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/add_movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/edit_movie/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/languages/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/Movies/movie_home/moviehome_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/forget_password/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/forget_password/forget_pass.dart';
import 'package:onlinebooking_adminside/presentation/screens/home/home_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/login/login_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/profile/change_password/ui/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/signUp/signup_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/splash/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/splash/splash_screen.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre/theatre_home.dart';
import 'package:onlinebooking_adminside/presentation/screens/theatre_details/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/screens/users/user_home.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/date_picker/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/genre_item_sheet/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/common/language_item_sheet/bloc/bloc_bloc.dart';
import 'package:onlinebooking_adminside/presentation/widgets/image_picker/bloc/bloc_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashScreenbloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => ForgetPassBloc(),
        ),
        BlocProvider(
          create: (context) => AddDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider(
          create: (context) => MovieBloc(
            MovieDatabaserepository(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              EditMovieBloc(movieRepository: MovieDatabaserepository()),
        ),
        BlocProvider(
          create: (context) => MovieDetailsBloc(
            movieRepository: MovieDatabaserepository(),
          ),
        ),
        BlocProvider(
          create: (context) => DatePickerBloc(),
        ),
        BlocProvider(
          create: (context) => MultipleItemSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => GenreSelectionBloc(),
        ),
        BlocProvider(
          create: (context) => LanguagesBloc(),
        ),
        BlocProvider(
          create: (context) => TheatresBloc(),
        ),
        BlocProvider(
          create: (context) => TheatreDeatilsBloc(),
        ),
        BlocProvider(
          create: (context) => ChangepasswordBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
              // headlineLarge: AppTextstyles.headlineLarge,
              // headlineMedium: AppTextstyles.headlineMedium,
              // headlineSmall: AppTextstyles.headlineSmall,
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.92,
                    MediaQuery.of(context).size.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white),
          ),
        ),
        routes: {
          '/signIn': (context) => const LoginScreen(),
          '/signUp': (context) => const SignUpScreen(),
          '/forgetPass': (context) => const ForgetPassScreen(),
          '/home': (context) => const HomeScreen(),
          '/splash': (context) => const SplashScreen(),
          '/addMovie': (context) => const AddMovieScreen(),
          '/movieHome': (context) => const MovieHomeScreen(),
          // '/editMovie': (context) => const EditMovieScreen(),
          '/userHome': (context) => const usersHomeScreen(),
          '/theatreHome': (context) => const TheatreHomeScreen()
        },
        home: const SplashScreen(),
      ),
    );
  }
}
