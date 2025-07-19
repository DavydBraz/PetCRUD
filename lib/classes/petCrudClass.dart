import 'package:pet_crud_dvd/classes/petClass.dart';

class PetCrudClass {//singleton
  static final PetCrudClass _instance = PetCrudClass._internal();//Cria uma única instância da classe
  factory PetCrudClass() => _instance;//Sempre retorna essa mesma instância

  PetCrudClass._internal();//	Construtor privado chamado apenas 1 vez

  final List<Pet> _pets = [];

  //Create
  void createPet(Pet pet) {
    _pets.add(pet);
    print("Pet criado com sucesso: $pet");
  }

  //Read
  List<Pet> getAllPets() {
    return List.unmodifiable(_pets);//Garante que ninguém fora da classe possa alterar _pets diretamente
  }

  //Delete
  void deletePet(String name) {
    _pets.removeWhere((pet) => pet.name == name);
    print("Pet removido do sistema: $name");
  }

  //Update
  void updatePet(String name, Pet newPet) {
    for (var i = 0; i < _pets.length; i++) {
      if (_pets[i].name == name) {
        _pets[i] = newPet;
        print("Pet atualizado no sistema: $newPet");
        return;
      }
    }
    print("Pet não encontrado para atualização.");
  }
}
