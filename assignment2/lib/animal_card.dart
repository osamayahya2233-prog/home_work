import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../animal.dart';

class AnimalCard extends StatefulWidget {
  final Animal animal;

  const AnimalCard({super.key, required this.animal});

  @override
  State<AnimalCard> createState() => _AnimalCardState();
}

class _AnimalCardState extends State<AnimalCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound() async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await _audioPlayer.play(AssetSource(widget.animal.soundPath));
      setState(() {
        _isPlaying = true;
      });

      // عند انتهاء الصوت
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() {
          _isPlaying = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // صورة الحيوان
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              widget.animal.imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.pets, size: 60, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          
          // معلومات الحيوان
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.animal.arabicName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      widget.animal.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  widget.animal.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                
                const SizedBox(height: 12),
                
                // زر تشغيل الصوت
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _playSound,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isPlaying ? Colors.redAccent : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: Icon(
                      _isPlaying ? Icons.stop : Icons.play_arrow,
                      size: 24,
                    ),
                    label: Text(
                      _isPlaying ? 'إيقاف الصوت' : 'تشغيل صوت ${widget.animal.arabicName}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}