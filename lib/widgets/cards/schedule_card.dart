import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String nome;
  final String tipo;
  final String hora;
  final String status;
  final String imageUrl;

  const ScheduleCard({
    super.key,
    required this.nome,
    required this.tipo,
    required this.hora,
    required this.status,
    required this.imageUrl,
  });

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case "confirmed":
        return Colors.green.shade400;
      case "pending":
        return Colors.yellow.shade600;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Foto
            CircleAvatar(backgroundImage: NetworkImage(imageUrl), radius: 25),
            const SizedBox(width: 10),

            // Informações principais
            Container(
              width: 180,
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(tipo, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 4),
                        Text(hora),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Status
            Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: getStatusColor().withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    color: getStatusColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
