import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopisan/blocs/authentication/authentication_bloc.dart';
import 'package:shopisan/blocs/edit_store/edit_store_bloc.dart';
import 'package:shopisan/blocs/post_creation/post_creation_bloc.dart';
import 'package:shopisan/blocs/profile_edit/profile_edit_bloc.dart';
import 'package:shopisan/blocs/registration/registration_bloc.dart';
import 'package:shopisan/components/StoreDetailScreenTab/PostsTabCommercial/PostsCommercialScreen/PostsCommercialScreen.dart';
import 'package:shopisan/screens/EditProfile.dart';
import 'package:shopisan/screens/EditStoreScreen.dart';
import 'package:shopisan/screens/ForgotPassword.dart';
import 'package:shopisan/screens/Login.dart';
import 'package:shopisan/screens/ManagePost.dart';
import 'package:shopisan/screens/Register.dart';
import 'package:shopisan/screens/ResetPasswordScreen.dart';
import 'package:shopisan/screens/StoreDetailScreen.dart';
import 'package:shopisan/screens/StoresScreen.dart';
import 'package:shopisan/screens/edit_store_selection_screen.dart';
import 'package:shopisan/screens/post_creation.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic args = settings.arguments;
    // final Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    // final UserRepository? userRepository = settings.arguments as UserRepository?;

    return MaterialPageRoute(
        settings: RouteSettings(name: settings.name),
        builder: (_) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              switch (settings.name) {
                case '/':
                  bool toLogin = null != args ? args['toLogin'] : false;
                  return StoresScreen(toLogin: toLogin);

                case '/store_detail':
                  return StoreDetailScreen(storeId: args!['storeId']);

                case '/manage_post':
                  return ManagePost();

                case '/post_detail':
                  return PostsCommercialScreen(
                      post: args!['post'],
                      store: null != args ? args['store'] : null);

                case '/create_post':
                  return BlocProvider<PostCreationBloc>(
                      create: (context) {
                        return PostCreationBloc()
                          ..add(IsStarted(
                              postId: null != args ? args['postId'] : null));
                      },
                      child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          bottomOpacity: 0.0,
                          elevation: 8,
                          iconTheme: IconThemeData(color: Colors.black),
                          title: Text(
                            args == null
                                ? AppLocalizations.of(context)!.createPost
                                : AppLocalizations.of(context)!.editPost,
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                        body: PostCreation(),
                      ));

                case '/login':
                  return LoginPage(userRepository: args);

                case '/register':
                  return BlocProvider<RegistrationBloc>(
                    create: (context) {
                      return RegistrationBloc();
                    },
                    child: RegisterScreen(),
                  );

                case '/forgot_password':
                  return ForgotPasswordScreen();

                case '/reset_password':
                  return ResetPasswordScreen(
                    email: args!["email"],
                  );

                case '/edit_profile':
                  return BlocProvider<ProfileEditBloc>(
                      create: (context) {
                        return ProfileEditBloc()..add(InitEvent());
                      },
                      child: Scaffold(
                        body: EditProfile(),
                      ));

                case '/edit_stores':
                  return EditStoreSelectionScreen();

                case '/edit_store':
                  return BlocProvider<EditStoreBloc>(
                      create: (context) {
                        return EditStoreBloc()
                          ..add(AppStartedEvent(
                              storeId: args?['storeId'] ?? null));
                      },
                      child: EditStore());

                default:
                  return _errorRoute();
              }
            },
          );
        });
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error"),
      ),
      body: Center(
        child: Center(
          child: Text("This location doesn't exists"),
        ),
      ),
    );
  }
}
