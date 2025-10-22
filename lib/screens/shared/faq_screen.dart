import 'package:app_med/widgets/cards/faq_card.dart';
import 'package:app_med/widgets/header/auth_app_bar.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AuthAppBar(title: "Perguntas frequentes", onBackTap: () => Navigator.pop(context)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FaqCard(
              question: 'Como posso agendar uma consulta?',
              answer:
                  'Para agendar uma consulta, basta pesquisar pelo nome do médico ou especialidade desejada.',
            ),
            FaqCard(
              question: 'Posso cancelar uma consulta?',
              answer: 'Sim! Vá até suas consultas agendadas e toque em “Cancelar”.',
            ),
            FaqCard(
              question: 'Como altero meus dados pessoais?',
              answer: 'Acesse o menu de configurações e toque em “Editar Perfil”.',
            ),
            FaqCard(
              question: 'Posso reagendar uma consulta?',
              answer: 'Sim! Basta acessar suas consultas agendadas e escolher a opção “Reagendar”.',
            ),
            FaqCard(
              question: 'Receberei lembretes sobre minhas consultas?',
              answer:
                  'Sim! Você receberá notificações automáticas algumas horas antes do horário marcado.',
            ),
            FaqCard(
              question: 'Preciso pagar para usar o app?',
              answer:
                  'Não! O uso do aplicativo é totalmente gratuito. Você só paga pela consulta com o médico, caso seja necessário.',
            ),
            FaqCard(
              question: 'Como vejo o histórico das minhas consultas?',
              answer:
                  'Vá até a aba “Consultas” e toque em “Histórico” para visualizar suas consultas anteriores.',
            ),
            FaqCard(
              question: 'O que fazer se eu esquecer minha senha?',
              answer:
                  'Na tela de login, toque em “Esqueci minha senha” e siga as instruções para redefini-la.',
            ),
          ],
        ),
      ),
    );
  }
}
