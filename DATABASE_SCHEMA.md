# Database Schema - Mody Alumni Connect

Complete Firestore database structure and API documentation.

## 📊 Database Structure

```
mody-alumni-connect (Firebase Project)
│
├── Authentication (Firebase Auth)
│   └── Users (Email/Password)
│
└── Firestore Database
    ├── users/
    ├── chatRooms/
    │   └── {chatRoomId}/
    │       └── messages/
    ├── notifications/
    ├── userNotifications/
    └── mentorshipRequests/
```

## 📑 Collections

### 1. `users` Collection

Stores all user profiles (students, alumni, CDC).

**Document ID**: User's Firebase Auth UID

```javascript
{
  // Common Fields (All Users)
  uid: string,                    // Firebase Auth UID
  email: string,                  // User email
  name: string,                   // Full name
  role: string,                   // 'student' | 'alumni' | 'cdc'
  phoneNumber: string?,           // Optional phone
  profileImageUrl: string?,       // Profile picture URL
  fcmToken: string?,             // Firebase Cloud Messaging token
  createdAt: timestamp,           // Account creation
  lastActive: timestamp?,         // Last app activity
  
  // Student Specific Fields
  enrollmentNumber: string?,      // University enrollment number
  department: string?,            // 'engineering' | 'science' | 'business'
  currentYear: string?,           // '1st Year', '2nd Year', etc.
  interests: string[]?,           // List of interests
  bookmarkedAlumni: string[]?,    // Array of alumni UIDs
  
  // Alumni Specific Fields
  graduationYear: string?,        // Year of graduation
  currentCompany: string?,        // Current employer
  currentPosition: string?,       // Job title
  linkedinUrl: string?,           // LinkedIn profile
  githubUrl: string?,             // GitHub profile
  resumeUrl: string?,             // Resume document
  mentoringAreas: string[]?,      // Areas willing to mentor
  skills: string[]?,              // Technical/soft skills
  clubs: object[]?,               // College clubs
  projects: object[]?,            // Projects undertaken
  certifications: object[]?,      // Certifications earned
  internships: object[]?,         // Internship experiences
  placementDetails: object?,      // First job details
  availableForMentorship: boolean? // Accepting requests
}
```

**Indexes Required**:
- `role` (for filtering by user type)
- `department` (for filtering by department)
- `availableForMentorship` (for finding available alumni)

**Sample Document**:
```javascript
// Student Example
{
  "uid": "abc123",
  "email": "student@mody.ac.in",
  "name": "Priya Sharma",
  "role": "student",
  "department": "engineering",
  "enrollmentNumber": "EN2024001",
  "currentYear": "2nd Year",
  "interests": ["Web Development", "AI/ML"],
  "bookmarkedAlumni": ["xyz789"],
  "createdAt": Timestamp,
  "lastActive": Timestamp
}

// Alumni Example
{
  "uid": "xyz789",
  "email": "alumni@company.com",
  "name": "Rahul Verma",
  "role": "alumni",
  "department": "engineering",
  "graduationYear": "2020",
  "currentCompany": "Google",
  "currentPosition": "Software Engineer",
  "skills": ["React", "Node.js", "Python"],
  "mentoringAreas": ["Career Guidance", "Interview Prep"],
  "availableForMentorship": true,
  "linkedinUrl": "https://linkedin.com/in/rahulverma",
  "createdAt": Timestamp,
  "lastActive": Timestamp
}
```

---

### 2. `chatRooms` Collection

Stores conversation metadata between users.

**Document ID**: `{userId1}_{userId2}` (sorted alphabetically)

```javascript
{
  chatRoomId: string,              // Document ID
  participants: string[],          // [userId1, userId2]
  participantDetails: {            // Cached user info
    [userId]: {
      name: string,
      imageUrl: string?
    }
  },
  lastMessage: string,             // Preview of last message
  lastMessageTime: timestamp,      // Time of last message
  unreadCount: {                   // Unread count per user
    [userId]: number
  },
  createdAt: timestamp             // Chat creation time
}
```

**Sample Document**:
```javascript
{
  "chatRoomId": "abc123_xyz789",
  "participants": ["abc123", "xyz789"],
  "participantDetails": {
    "abc123": {
      "name": "Priya Sharma",
      "imageUrl": "https://..."
    },
    "xyz789": {
      "name": "Rahul Verma",
      "imageUrl": "https://..."
    }
  },
  "lastMessage": "Thank you for the guidance!",
  "lastMessageTime": Timestamp,
  "unreadCount": {
    "abc123": 0,
    "xyz789": 2
  },
  "createdAt": Timestamp
}
```

---

### 3. `messages` Subcollection

Located at: `chatRooms/{chatRoomId}/messages/`

**Document ID**: Auto-generated UUID

```javascript
{
  messageId: string,               // Document ID
  senderId: string,                // User who sent
  senderName: string,              // Sender's name
  message: string,                 // Message content
  timestamp: timestamp,            // When sent
  isRead: boolean,                 // Read status
  imageUrl: string?,               // Optional image
  fileUrl: string?                 // Optional file
}
```

**Sample Document**:
```javascript
{
  "messageId": "msg001",
  "senderId": "abc123",
  "senderName": "Priya Sharma",
  "message": "Hi! Can you guide me about placements?",
  "timestamp": Timestamp,
  "isRead": true
}
```

---

### 4. `notifications` Collection

CDC-posted notifications visible to all users.

**Document ID**: Auto-generated

```javascript
{
  notificationId: string,          // Document ID
  title: string,                   // Notification title
  body: string,                    // Notification body
  type: string,                    // 'opportunity' | 'event' | 'announcement'
  imageUrl: string?,               // Optional image
  link: string?,                   // Optional external link
  data: object?,                   // Additional metadata
  createdAt: timestamp,            // When posted
  createdBy: string,               // CDC user ID
  createdByName: string,           // CDC user name
  targetAudience: string[],        // ['all'] or ['student', 'alumni']
  isPinned: boolean                // Show at top
}
```

**Sample Document**:
```javascript
{
  "notificationId": "notif001",
  "title": "Google Summer of Code 2024",
  "body": "Applications are now open for GSoC 2024...",
  "type": "opportunity",
  "link": "https://summerofcode.withgoogle.com/",
  "createdAt": Timestamp,
  "createdBy": "cdc123",
  "createdByName": "CDC Official",
  "targetAudience": ["all"],
  "isPinned": true
}
```

---

### 5. `userNotifications` Collection

Tracks which users have seen which notifications.

**Document ID**: Auto-generated

```javascript
{
  id: string,                      // Document ID
  userId: string,                  // User who received
  notificationId: string,          // Reference to notification
  isRead: boolean,                 // Read status
  receivedAt: timestamp            // When received
}
```

**Sample Document**:
```javascript
{
  "id": "un001",
  "userId": "abc123",
  "notificationId": "notif001",
  "isRead": false,
  "receivedAt": Timestamp
}
```

---

### 6. `mentorshipRequests` Collection

Formal mentorship requests from students to alumni.

**Document ID**: Auto-generated UUID

```javascript
{
  requestId: string,               // Document ID
  studentId: string,               // Student's UID
  studentName: string,             // Student's name
  alumniId: string,                // Alumni's UID
  alumniName: string,              // Alumni's name
  message: string,                 // Request message
  status: string,                  // 'pending' | 'accepted' | 'rejected'
  createdAt: timestamp,            // Request time
  respondedAt: timestamp?          // Response time
}
```

**Sample Document**:
```javascript
{
  "requestId": "req001",
  "studentId": "abc123",
  "studentName": "Priya Sharma",
  "alumniId": "xyz789",
  "alumniName": "Rahul Verma",
  "message": "I'm interested in web development and would love your guidance",
  "status": "pending",
  "createdAt": Timestamp
}
```

---

## 🔐 Security Rules

### Production-Ready Firestore Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper Functions
    function isSignedIn() {
      return request.auth != null;
    }
    
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    function hasRole(role) {
      return isSignedIn() && 
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == role;
    }
    
    function isParticipant(participants) {
      return request.auth.uid in participants;
    }
    
    // Users Collection
    match /users/{userId} {
      allow read: if isSignedIn();
      allow create: if isSignedIn() && isOwner(userId);
      allow update: if isSignedIn() && isOwner(userId);
      allow delete: if false; // Prevent user deletion
    }
    
    // Chat Rooms
    match /chatRooms/{chatRoomId} {
      allow read: if isSignedIn() && 
        isParticipant(resource.data.participants);
      allow create: if isSignedIn();
      allow update: if isSignedIn() && 
        isParticipant(resource.data.participants);
      
      // Messages Subcollection
      match /messages/{messageId} {
        allow read: if isSignedIn();
        allow create: if isSignedIn();
        allow update: if isSignedIn();
      }
    }
    
    // Notifications
    match /notifications/{notificationId} {
      allow read: if isSignedIn();
      allow create: if hasRole('cdc');
      allow update: if hasRole('cdc');
      allow delete: if hasRole('cdc');
    }
    
    // User Notifications
    match /userNotifications/{userNotifId} {
      allow read: if isSignedIn() && 
        isOwner(resource.data.userId);
      allow create: if isSignedIn();
      allow update: if isSignedIn() && 
        isOwner(resource.data.userId);
    }
    
    // Mentorship Requests
    match /mentorshipRequests/{requestId} {
      allow read: if isSignedIn() && (
        isOwner(resource.data.studentId) || 
        isOwner(resource.data.alumniId)
      );
      allow create: if isSignedIn() && hasRole('student');
      allow update: if isSignedIn() && 
        isOwner(resource.data.alumniId);
      allow delete: if false;
    }
  }
}
```

---

## 📍 Common Queries

### Get All Alumni
```dart
FirebaseFirestore.instance
  .collection('users')
  .where('role', isEqualTo: 'alumni')
  .get();
```

### Filter Alumni by Department
```dart
FirebaseFirestore.instance
  .collection('users')
  .where('role', isEqualTo: 'alumni')
  .where('department', isEqualTo: 'engineering')
  .get();
```

### Get User's Chat Rooms
```dart
FirebaseFirestore.instance
  .collection('chatRooms')
  .where('participants', arrayContains: userId)
  .orderBy('lastMessageTime', descending: true)
  .snapshots();
```

### Get Messages in Chat
```dart
FirebaseFirestore.instance
  .collection('chatRooms')
  .doc(chatRoomId)
  .collection('messages')
  .orderBy('timestamp', descending: true)
  .snapshots();
```

### Get Latest Notifications
```dart
FirebaseFirestore.instance
  .collection('notifications')
  .orderBy('createdAt', descending: true)
  .limit(50)
  .snapshots();
```

### Get Mentorship Requests for Alumni
```dart
FirebaseFirestore.instance
  .collection('mentorshipRequests')
  .where('alumniId', isEqualTo: userId)
  .orderBy('createdAt', descending: true)
  .snapshots();
```

---

## 🔄 Data Flow Examples

### Sending a Message

1. **Create/Get Chat Room**
```dart
String chatRoomId = '${userId1}_${userId2}';
await FirebaseFirestore.instance
  .collection('chatRooms')
  .doc(chatRoomId)
  .set({...});
```

2. **Add Message**
```dart
await FirebaseFirestore.instance
  .collection('chatRooms')
  .doc(chatRoomId)
  .collection('messages')
  .add({...});
```

3. **Update Chat Room**
```dart
await FirebaseFirestore.instance
  .collection('chatRooms')
  .doc(chatRoomId)
  .update({
    'lastMessage': message,
    'lastMessageTime': FieldValue.serverTimestamp(),
    'unreadCount.$receiverId': FieldValue.increment(1)
  });
```

### Posting a Notification

1. **Create Notification**
```dart
DocumentReference docRef = await FirebaseFirestore.instance
  .collection('notifications')
  .add({...});
```

2. **Create User Notifications**
```dart
// For each target user
await FirebaseFirestore.instance
  .collection('userNotifications')
  .add({
    'userId': targetUserId,
    'notificationId': docRef.id,
    'isRead': false,
    'receivedAt': FieldValue.serverTimestamp()
  });
```

3. **Send FCM Push Notification**
```dart
// Handled by Cloud Functions or Admin SDK
```

---

## 📊 Storage Estimates

### Per User Data
- Student: ~5 KB
- Alumni: ~20 KB (with detailed profile)
- CDC: ~2 KB

### Per Message: ~1 KB
### Per Notification: ~2 KB

### Estimated Database Size (1000 users)
- Users: 10 MB
- Messages (10,000): 10 MB
- Notifications (500): 1 MB
- **Total: ~25 MB**

---

## 🚀 Performance Optimization

### Indexing Strategy
1. Composite indexes for complex queries
2. Single-field indexes for simple filters
3. Array-contains for participant lookups

### Caching Strategy
1. Cache user profiles (rarely change)
2. Cache chat list (update on new message)
3. Real-time for messages (immediate updates)

### Pagination
- Limit queries to 20-50 documents
- Use `startAfter()` for infinite scroll
- Cache previous pages

---

## 🔧 Maintenance

### Regular Tasks
1. Clean up old messages (archive after 6 months)
2. Remove inactive users (after 2 years)
3. Optimize indexes
4. Monitor query performance

### Backup Strategy
1. Daily automated backups
2. Export to Cloud Storage
3. Keep last 30 days
4. Monthly full backups

---

**Last Updated**: 2024
**Schema Version**: 1.0.0
