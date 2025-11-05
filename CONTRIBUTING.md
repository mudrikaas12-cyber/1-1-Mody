# Contributing to Mody Alumni Connect

First off, thank you for considering contributing to Mody Alumni Connect! It's people like you that make this project a great tool for the Mody University community.

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct:

- Be respectful and inclusive
- Welcome newcomers and beginners
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards other community members

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include as many details as possible:

**Bug Report Template:**
```markdown
**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Device Information:**
 - Device: [e.g. iPhone 12, Samsung Galaxy S21]
 - OS: [e.g. iOS 15.0, Android 12]
 - App Version: [e.g. 1.0.0]

**Additional context**
Add any other context about the problem here.
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

**Enhancement Template:**
```markdown
**Is your feature request related to a problem?**
A clear description of what the problem is.

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request.
```

### Pull Requests

#### Before Submitting

1. **Check existing PRs**: Ensure no one else is working on the same thing
2. **Create an issue**: Discuss your idea before starting work
3. **Follow code style**: Maintain consistency with existing code
4. **Write tests**: Add tests for new features
5. **Update documentation**: Keep README and comments up to date

#### Pull Request Process

1. **Fork the repository** and create your branch from `main`:
   ```bash
   git checkout -b feature/amazing-feature
   ```

2. **Make your changes**:
   - Follow the project's code style
   - Write clear, concise commit messages
   - Add comments for complex logic
   - Update documentation as needed

3. **Test your changes**:
   ```bash
   # Run tests
   flutter test
   
   # Check formatting
   flutter format .
   
   # Analyze code
   flutter analyze
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add amazing feature"
   ```

5. **Push to your fork**:
   ```bash
   git push origin feature/amazing-feature
   ```

6. **Open a Pull Request**:
   - Provide a clear title and description
   - Reference related issues
   - Include screenshots for UI changes
   - Wait for review and address feedback

## Development Setup

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK
- Git
- Firebase account
- IDE (VS Code or Android Studio)

### Local Development

1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/mody-alumni-connect.git
   cd mody-alumni-connect
   ```

2. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/mody-alumni-connect.git
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Set up Firebase (see SETUP_GUIDE.md)

5. Run the app:
   ```bash
   flutter run
   ```

### Keeping Your Fork Updated

```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Code Style Guidelines

### Dart/Flutter Style

Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style):

```dart
// Good: Use camelCase for variable names
String userName = 'John Doe';

// Good: Use PascalCase for class names
class UserProfile extends StatelessWidget {}

// Good: Use lowerCamelCase for file names
// user_profile_screen.dart

// Good: Use descriptive names
String calculateTotalPrice() {}

// Bad: Avoid abbreviations
String calcTotPrc() {} // Don't do this
```

### Widget Organization

```dart
class MyWidget extends StatelessWidget {
  // 1. Constants
  static const double padding = 16.0;
  
  // 2. Final fields
  final String title;
  final VoidCallback onPressed;
  
  // 3. Constructor
  const MyWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });
  
  // 4. Build method
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  // 5. Private helper methods
  void _handleTap() {}
}
```

### Provider Usage

```dart
// Good: Use Consumer for specific rebuilds
Consumer<AuthProvider>(
  builder: (context, authProvider, child) {
    return Text(authProvider.user?.name ?? '');
  },
)

// Good: Use Provider.of with listen: false for events
onPressed: () {
  Provider.of<AuthProvider>(context, listen: false).signOut();
}

// Bad: Don't use Provider.of in build without Consumer
// This rebuilds the entire widget
final authProvider = Provider.of<AuthProvider>(context);
```

### Async/Await

```dart
// Good: Handle errors properly
Future<void> fetchData() async {
  try {
    final data = await apiService.getData();
    setState(() {
      _data = data;
    });
  } catch (e) {
    print('Error: $e');
    // Show error to user
  }
}

// Good: Use mounted check after await
Future<void> loadData() async {
  final data = await fetchData();
  if (mounted) {
    setState(() {
      _data = data;
    });
  }
}
```

### Comments

```dart
// Good: Explain why, not what
// Calculate discount based on user's tier and purchase history
final discount = _calculateDiscount(user);

// Bad: State the obvious
// Set the name to the user's name
name = user.name;

// Good: Document complex logic
/// Calculates the mentorship match score between student and alumni.
/// 
/// Takes into account:
/// - Department alignment
/// - Skill overlap
/// - Career path similarity
/// 
/// Returns a score between 0-100
int calculateMatchScore(Student student, Alumni alumni) {
  // Implementation
}
```

## Commit Message Guidelines

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, etc.)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

### Examples

```bash
feat(auth): add password reset functionality

Implemented password reset feature allowing users to reset their
password via email. Added new screen and integrated with Firebase Auth.

Closes #123

---

fix(chat): resolve message ordering issue

Messages were sometimes appearing out of order due to timestamp
comparison bug. Fixed by using Firestore serverTimestamp.

Fixes #456

---

docs(readme): update installation instructions

Added detailed steps for Firebase configuration and included
troubleshooting section.
```

## Testing Guidelines

### Unit Tests

```dart
// test/models/user_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mody_alumni_connect/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create user from map', () {
      final map = {
        'uid': '123',
        'email': 'test@test.com',
        'name': 'Test User',
        'role': 'student',
      };
      
      final user = UserModel.fromMap(map);
      
      expect(user.uid, '123');
      expect(user.email, 'test@test.com');
      expect(user.name, 'Test User');
    });
  });
}
```

### Widget Tests

```dart
// test/widgets/alumni_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mody_alumni_connect/widgets/alumni_card.dart';

void main() {
  testWidgets('AlumniCard displays alumni information', 
    (WidgetTester tester) async {
    final alumni = UserModel(/* ... */);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AlumniCard(alumni: alumni),
        ),
      ),
    );
    
    expect(find.text(alumni.name), findsOneWidget);
    expect(find.text(alumni.currentCompany!), findsOneWidget);
  });
}
```

## Documentation

### Code Documentation

- Add dartdoc comments for public APIs
- Keep comments up to date with code changes
- Use `///` for documentation comments
- Use `//` for implementation comments

```dart
/// Sends a mentorship request from a student to an alumni.
///
/// The [studentId] and [alumniId] must be valid user IDs in the database.
/// Returns the request ID on success, throws an exception on failure.
///
/// Example:
/// ```dart
/// final requestId = await sendMentorshipRequest(
///   studentId: 'student123',
///   alumniId: 'alumni456',
///   message: 'I would like career guidance',
/// );
/// ```
Future<String> sendMentorshipRequest({
  required String studentId,
  required String alumniId,
  required String message,
}) async {
  // Implementation
}
```

### README Updates

When adding features, update:
- Feature list
- Screenshots (if UI changed)
- API documentation
- Setup instructions (if needed)

## Project Structure

When adding new features, follow this structure:

```
lib/
├── models/           # Data models
├── providers/        # State management
├── screens/          # UI screens
│   ├── auth/        # Authentication screens
│   ├── student/     # Student-specific screens
│   ├── alumni/      # Alumni-specific screens
│   ├── cdc/         # CDC-specific screens
│   └── common/      # Shared screens
├── widgets/          # Reusable widgets
├── services/         # Business logic & API calls
├── utils/            # Utilities and helpers
└── main.dart         # Entry point
```

## Review Process

### What Reviewers Look For

1. **Code Quality**
   - Follows style guidelines
   - No unnecessary complexity
   - Proper error handling
   - Efficient algorithms

2. **Testing**
   - Adequate test coverage
   - Tests pass consistently
   - Edge cases considered

3. **Documentation**
   - Code is well commented
   - README updated if needed
   - Breaking changes noted

4. **User Experience**
   - UI is responsive
   - Loading states handled
   - Error messages are clear

### Addressing Review Comments

- Respond to all comments
- Make requested changes
- Ask questions if unclear
- Be open to suggestions
- Update PR description if scope changes

## Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Credited in release notes
- Mentioned in project README
- Given shoutouts on social media

## Questions?

- Check the [README](README.md)
- Read the [Setup Guide](SETUP_GUIDE.md)
- Open an issue for discussion
- Contact: dev@modyalumni.com

Thank you for contributing to Mody Alumni Connect! 🎉
