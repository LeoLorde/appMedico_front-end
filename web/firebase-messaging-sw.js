importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyAOJWwEeRi9a73QeODGwMZTiK9WaPoc3G8",
  authDomain: "doctorhub-1f3c2.firebaseapp.com",
  projectId: "doctorhub-1f3c2",
  storageBucket: "doctorhub-1f3c2.firebasestorage.app",
  messagingSenderId: "401664143901",
  appId: "1:401664143901:web:26c98570d5768cbfd04cf4"
});

const messaging = firebase.messaging();

// Gerenciador de mensagens em segundo plano para a Web
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
