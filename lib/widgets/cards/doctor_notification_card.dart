import 'package:flutter/material.dart';

class DoctorNotificationCard extends StatelessWidget {
  final String nome;
  final String data;
  final String motivo;
  final String imageUrl;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const DoctorNotificationCard({
    super.key,
    required this.nome,
    required this.data,
    required this.motivo,
    required this.imageUrl,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Linha com foto e dados
            Row(
              children: [
                CircleAvatar(radius: 25, backgroundImage: AssetImage(imageUrl)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(
                        "Data: $data",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                      Text(
                        "Motivo: $motivo",
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Botões
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text("Aceitar"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text("Recusar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
