import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbloccrud/presentation/add_product.dart';
import 'package:flutterbloccrud/presentation/dashboard/dashboard.dart';
import 'package:flutterbloccrud/presentation/sign_in/sign_in.dart';

import '../presentation/sign_up/sign_up.dart';

class RouterPageAnimation {
  static routePageAnimation(BuildContext context, Route route) {
    Navigator.push(context, route);
  }

  static Route goToSignIn() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
      return TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 3000),
          builder: (context, value, child) {
            return ShaderMask(
                blendMode: BlendMode.colorBurn,
                shaderCallback: (rect) {
                  return RadialGradient(
                          radius: value * 5,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.blue.withOpacity(0.8),
                            Colors.blue.withOpacity(0.8),
                          ],
                          stops: [0.0, 0.55, 0.6, 1.0],
                          center: const FractionalOffset(0.5, 0.5))
                      .createShader(rect);
                },
                child: const SignIn());
          });
    });
  }

  static Route goToSignUp() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
      return TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 3000),
          builder: (context, value, child) {
            return ShaderMask(
                blendMode: BlendMode.colorBurn,
                shaderCallback: (rect) {
                  return RadialGradient(
                          radius: value * 5,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.blue.withOpacity(0.8),
                            Colors.blue.withOpacity(0.8),
                          ],
                          stops: [0.0, 0.55, 0.6, 1.0],
                          center: const FractionalOffset(0.5, 0.5))
                      .createShader(rect);
                },
                child: const SignUp());
          });
    });
  }

  static Route goToDashBoard() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
      return TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 3000),
          builder: (context, value, child) {
            return ShaderMask(
                blendMode: BlendMode.colorBurn,
                shaderCallback: (rect) {
                  return RadialGradient(
                          radius: value * 5,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.blue.withOpacity(0.8),
                            Colors.blue.withOpacity(0.8),
                          ],
                          stops: [0.0, 0.55, 0.6, 1.0],
                          center: const FractionalOffset(0.5, 0.5))
                      .createShader(rect);
                },
                child: const DashBoard());
          });
    });
  }

  static Route goToAddProduct() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) =>
          AddProductScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),

          // child: SizeTransition(
          //   sizeFactor: animation,
          //   axis: Axis.horizontal,
          //   axisAlignment: -1,
          //     child: Padding(
          //           padding: padding,
          //           child: child(index),
          //         ),
          // ),
          //
          // child: Align(
          //   child: SizeTransition(
          //     sizeFactor: animation,
          //     child: child,
          //     axisAlignment: 0.0,
          //   ),
          // ),

          // child: FadeTransition(
          //   opacity:animation,
          //   child: child,
          // ),

          child: ScaleTransition(
            scale: animation,
            child: child,
          ),

          // child: SlideTransition(
          //   position: Tween<Offset>(
          //     begin: Offset(0, -0.1),
          //     end: Offset.zero,
          //   ).animate(animation),
          //   child: Padding(
          //     padding: padding,
          //     child: child(index),
          //   ),
          // ),
        );
        // return SlideTransition(
        //   position: animation.drive(tween),
        //   child: child,
        // );
      },
    );
  }
}
