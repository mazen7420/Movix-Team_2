import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:movix/features/home/widgets/home_header.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1512),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1512),
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: Center(
        child: BlocBuilder<ProfileCubit, String>(
          builder: (context, imagePath) {
            return InkWell(
              onTap: () {
                context.read<ProfileCubit>().changeImage();
              },
              customBorder: const CircleBorder(),
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HomeHeader.darkColor,
                      border: Border.all(color: HomeHeader.greenColor, width: 2),
                    ),
                    child: ClipOval(
                      child: imagePath == ''
                          ? const Icon(Icons.person, color: HomeHeader.greenColor, size: 70)
                          : Image.file(File(imagePath), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: HomeHeader.greenColor,
                      ),
                      child: const Icon(
                        Symbols.photo_camera,
                        size: 18,
                        color: Color(0xFF0B1512),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}