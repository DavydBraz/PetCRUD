import 'dart:io';

import 'package:pet_crud_dvd/utils/genre.dart';
import 'package:pet_crud_dvd/utils/size.dart';

class Pet {
  final PetSize size;
  final String name;
  final String breed; // raça
  final File? image;
  final PetGenre genre;
  final int age;
  //final List vaccines;

  Pet({
    required this.size,
    required this.name,
    required this.breed,
    required this.image,
    required this.genre,
    required this.age,
    //required this.vaccines,
  });

}