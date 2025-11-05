// file: web/firebase-messaging-sw.js

importScripts("https://www.gstatic.com/firebasejs/10.12.3/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.12.3/firebase-messaging-compat.js");

// Initialize the Firebase app in the service worker
const firebaseConfig = {
  apiKey: "AIzaSyBAGTaMKEvkeRRPswsxti0DQzi1CyAdkPk",
  authDomain: "mody-101.firebaseapp.com",
  projectId: "mody-101",
  storageBucket: "mody-101.firebasestorage.app",
  messagingSenderId: "426700103849",
  appId: "1:426700103849:web:0b08d9670392773e3f49b8"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/favicon.png'
  };
  return self.registration.showNotification(notificationTitle, notificationOptions);
});