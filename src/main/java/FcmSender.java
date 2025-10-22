public class FcmSender{  
  private static void sendMessageToFcmRegistrationToken() throws Exception {
    String registrationToken = "cvG7w-6oSe-G6ju53QlSUi:APA91bG2QHZbt6O4W08dg_Pxl7gGiyfq4Dd9Ac2MUbvXG2sNwJHc6WVteOV1wNouDxhLffcklKSRXhjAE-_bF83DhaC3D5VLw0bnSapXhxMTwiwV1WkO5mQ";
    Message message =
        Message.builder()
            .putData("FCM", "https://firebase.google.com/docs/cloud-messaging")
            .putData("flutter", "https://flutter.dev/")
            .setNotification(
                Notification.builder()
                    .setTitle("Try this new app")
                    .setBody("Learn how FCM works with Flutter")
                    .build())
            .setToken(registrationToken)
            .build();

    FirebaseMessaging.getInstance().send(message);

    System.out.println("Message to FCM Registration Token sent successfully!!");
  }
}