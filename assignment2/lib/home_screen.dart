import 'package:flutter/material.dart';
import '../animal_card.dart';
import '../animals_data.dart';
import '../animal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'الكل';

  List<Animal> get _filteredAnimals {
    if (_selectedCategory == 'الكل') {
      return AnimalsData.animals;
    }
    return AnimalsData.animals
        .where((animal) => animal.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text(
          'أصوات وصور الحيوانات',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      
      body: Column(
        children: [
          // فئات الحيوانات
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AnimalsData.categories.length,
              itemBuilder: (context, index) {
                final category = AnimalsData.categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    selectedColor: Colors.green[100],
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          
          const Divider(height: 1),
          
          // قائمة الحيوانات
          Expanded(
            child: _filteredAnimals.isEmpty
                ? const Center(
                    child: Text(
                      'لا توجد حيوانات في هذه الفئة',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _filteredAnimals.length,
                    itemBuilder: (context, index) {
                      final animal = _filteredAnimals[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AnimalCard(animal: animal),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      // معلومات التطبيق
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.green[50],
        child: const Center(
          child: Text(
            'تطبيق تعليمي للأطفال - تعرف على الحيوانات وأصواتها',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}