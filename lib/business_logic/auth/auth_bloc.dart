import 'package:bloc/bloc.dart';
import 'package:bruva/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is StartRegister) {
        _handleRegister(event, state);
      } else if (event is StartLogin) {
        _handleLogin(event);
      } else if (event is SignOut) {
        _handleSignOut();
      } else if (event is LoginWithGoogle) {
        _handleGoogleLogin();
      }
      if (event is ResetPassword) {
        _handlePasswordReset(event.email);
      }
      if (event is CheckForLogin) {
        _checkForLogin();
      }

    });
  }

  _handleRegister(StartRegister event, state) async {
    try {
      emit(AuthLoading());

      await UserRepository().register(event.mail, event.password).then((value) {
      _checkForLogin();
      });

    } catch (e) {
      print(e.toString());
      emit(AuthError(e.toString()));
    }
  }



  _handleLogin(StartLogin event) async {
    try {
      emit(AuthLoading());
      final res = await UserRepository()
          .signInWithCredentials(event.mail, event.password);
      if (res is UserCredential) {
        emit(LoggedIn());
      } else {
        emit(AuthInitial());
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  _handleGoogleLogin() async {
    try {
      emit(AuthLoading());
      await UserRepository().signInWithGoogle();
      FirebaseAuth.instance.currentUser == null
          ? emit(AuthInitial())
          : emit(LoggedIn());
    } catch (e) {
      debugPrint('error:${e.toString()}');
      emit(AuthError(e.toString()));
    }
  }

  _handlePasswordReset(email) async {
    try {
      emit(AuthLoading());
      await UserRepository().forgetPassword(email);
      emit(ResetCodeSent());
    } catch (e) {
      print(e.toString());
    }
  }

  _handleSignOut() async {
    try {
      emit(AuthLoading());
      await UserRepository().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  _checkForLogin() async {
    try {
      User? res =  FirebaseAuth.instance.currentUser;
      res!.uid.isEmpty ? emit(AuthInitial()) : emit(LoggedIn());
    } catch (e) {
      print(e.toString());
    }
  }
}
