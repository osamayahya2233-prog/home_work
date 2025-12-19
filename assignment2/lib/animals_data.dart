import '../animal.dart';

class AnimalsData {
  static List<Animal> animals = [
    Animal(
      id: '1',
      name: 'Lion',
      arabicName: 'أسد',
      imagePath: 'assets/images/Lion.png',
      soundPath: 'sounds/lion.mp3',
      description: 'الأسد ملك الغابة، يعيش في مجموعات تسمى قطيع',
      category: 'حيوانات برية',
    ),
    Animal(
      id: '2',
      name: 'Elephant',
      arabicName: 'فيل',
      imagePath: 'assets/images/Elephant.png',
      soundPath: 'sounds/elephant.mp3',
      description: 'الفيل أكبر حيوان بري، معروف بذاكرته القوية',
      category: 'حيوانات برية',
    ),
    Animal(
      id: '3',
      name: 'Cat',
      arabicName: 'قط',
      imagePath: 'assets/images/Cat.png',
      soundPath: 'sounds/cat.mp3',
      description: 'القطط من الحيوانات الأليفة المحببة',
      category: 'حيوانات أليفة',
    ),
    Animal(
      id: '4',
      name: 'Dog',
      arabicName: 'كلب',
      imagePath: 'assets/images/Dog.png',
      soundPath: 'sounds/dog.mp3',
      description: 'الكلب صديق الإنسان المخلص',
      category: 'حيوانات أليفة',
    ),
    Animal(
      id: '5',
      name: 'Bird',
      arabicName: 'طائر',
      imagePath: 'assets/images/Bird.png',
      soundPath: 'sounds/bird.mp3',
      description: 'الطيور تتميز بقدرتها على الطيران',
      category: 'طيور',
    ),
    Animal(
      id: '6',
      name: 'Horse',
      arabicName: 'حصان',
      imagePath: 'assets/images/Horse.png',
      soundPath: 'sounds/horse.mp3',
      description: 'الحصان معروف بسرعته وقوته',
      category: 'حيوانات مزرعة',
    ),
    Animal(
      id: '7',
      name: 'Rooster',
      arabicName: 'ديك',
      imagePath: 'assets/images/Rooster.png',
      soundPath: 'sounds/rooster.mp3',
      description: 'الديك يصيح عند شروق الشمس',
      category: 'طيور',
    ),
  ];

  static List<String> get categories {
    Set<String> categoriesSet = animals.map((animal) => animal.category).toSet();
    return ['الكل', ...categoriesSet];
  }
}