# Sales Bets - Realistic Seed Data 🌱

This document explains how to use the realistic seed data system to populate your Sales Bets app with professional, authentic-looking content.

## 📊 What's Included

### 🏆 **8 Realistic Sales Teams**
- **Revenue Riders** - Enterprise software sales team (SaaS solutions)
- **Quota Crushers** - B2B fintech sales professionals 
- **Deal Dynamos** - Healthcare technology sales experts
- **Pipeline Pioneers** - Marketing automation specialists
- **Closing Champions** - Insurance sales team
- **Sales Spartans** - Real estate professionals
- **Territory Titans** - Manufacturing sales reps
- **Commission Kings** - Luxury automotive sales team

Each team includes:
- Realistic follower counts (2K-6K)
- Win records (12-31 wins)
- Total revenue figures ($1.8M-$4.2M)
- Professional descriptions
- Color-coded profile images

### 🎯 **6 Professional Sales Events**
- **Q1 Revenue Challenge** - Quarterly revenue competition
- **Cold Call Championship** - Prospecting skills test
- **Enterprise Deal Derby** - Large account showdown ($50K+ deals)
- **New Client Acquisition Sprint** - 2-week client onboarding race
- **Referral Network Bonanza** - Customer referral generation
- **Demo Conversion Masters** - Demo-to-close conversion rate competition

Each event includes:
- Realistic betting odds (1.6x - 3.2x multipliers)
- Live and upcoming statuses
- Professional descriptions
- Bet statistics (89-567 bets placed)
- Credit wagering amounts

### 📺 **5 Authentic Live Streams**
- Live leaderboard updates
- Training sessions
- Championship finals
- Workshop content
- Masterclass streams

Each stream includes:
- Realistic viewer counts (567-2,847 viewers)
- Professional thumbnails
- Live/offline status
- Event connections

## 🚀 How to Seed Data

### Method 1: Using the Developer Tools UI (Recommended)

1. **Run the app** in development mode
2. **Navigate to Profile** screen
3. **Tap "Developer Tools"** (red warning icon)
4. **Use the buttons** to manage data:
   - **"Seed Initial Data"** - Add data if none exists
   - **"Re-seed Data (Force)"** - Replace all existing data
   - **"Clear All Data"** - Remove everything
5. **Monitor the status** messages and database statistics

### Method 2: Using Code

```dart
import 'package:your_app/services/data/data_seeder.dart';

// Initialize the seeder
final seeder = DataSeeder();

// Seed all data
await seeder.seedAllData();

// Force re-seed (overwrites existing)
await seeder.seedAllData(forceReseed: true);

// Clear all data
await seeder.clearAllData();

// Check if data exists
final exists = await seeder.dataExists();

// Get statistics
final stats = await seeder.getDataStats();
```

### Method 3: Direct Access to Seed Data

```dart
import 'package:your_app/services/data/seed_data.dart';

// Get all teams
final teams = SeedData.teams;

// Get live events
final liveEvents = SeedData.getLiveEvents();

// Get top performing teams
final topTeams = SeedData.getTopTeams(limit: 3);

// Get trending teams by followers
final trending = SeedData.getTrendingTeams(limit: 6);

// Get live streams
final liveStreams = SeedData.getLiveStreams();

// Get teams for specific event
final event = SeedData.events.first;
final eventTeams = SeedData.getTeamsForEvent(event);
```

## 💾 Database Structure

The seed data creates the following Firestore collections:

```
📁 teams/
├── team1 (Revenue Riders)
├── team2 (Quota Crushers)
├── team3 (Deal Dynamos)
└── ... (8 teams total)

📁 events/
├── event1 (Q1 Revenue Challenge)
├── event2 (Cold Call Championship) 
├── event3 (Enterprise Deal Derby)
└── ... (6 events total)

📁 streams/
├── stream1 (Q1 Revenue Live)
├── stream2 (Cold Call Finals)
├── stream3 (Pipeline Training)
└── ... (5 streams total)
```

## 🎨 UI Integration

The seed data is automatically integrated into:

### **Home Screen**
- Shows live and upcoming events from `SeedData.events`
- Displays trending teams from `SeedData.getTrendingTeams()`
- Real betting odds and team information

### **Live Streams Screen**
- Uses `SeedData.streams` for all stream content
- Shows realistic viewer counts and descriptions
- Proper live/offline status indicators

### **Betting Screen**
- Teams and events pulled from seed data
- Realistic odds and team statistics
- Professional team names and descriptions

## 🔧 Development Tips

### **Testing Different Scenarios**

```dart
// Test with only live events
final liveEvents = SeedData.getLiveEvents();

// Test with upcoming events
final upcomingEvents = SeedData.getUpcomingEvents();

// Test team performance rankings
final topTeams = SeedData.getTopTeams(limit: 3);

// Test follower-based trending
final trendingTeams = SeedData.getTrendingTeams(limit: 5);
```

### **Customizing Data**

You can modify `lib/services/data/seed_data.dart` to:
- Add more teams with your preferred names
- Create additional events with custom descriptions
- Adjust follower counts, win records, and revenue figures
- Add more live streams with specific content

### **Production Considerations**

- Remove the "Developer Tools" menu item before production
- Consider using real images instead of placeholder URLs
- Update placeholder URLs with your actual streaming infrastructure
- Add proper error handling for missing data

## 📱 Screenshots & Examples

When seeded, your app will show:

- **Professional team names** like "Revenue Riders" and "Pipeline Pioneers"
- **Realistic follower counts** like "4.8K" and "6.2K" 
- **Authentic events** like "Cold Call Championship" and "Enterprise Deal Derby"
- **Professional descriptions** for all teams, events, and streams
- **Realistic betting odds** ranging from 1.6x to 3.2x multipliers
- **Live viewer counts** from 567 to 2,847 viewers

## 🚨 Important Notes

- Always test the seeding process in a development environment first
- The Developer Tools screen includes warning messages about production usage
- Data seeding is idempotent - running it multiple times won't duplicate data (unless using `forceReseed`)
- All placeholder URLs should be replaced with real endpoints in production
- The seed data creates realistic but fictional teams and events

## 🛠️ Troubleshooting

**Data not appearing?**
- Check Firestore security rules allow read/write access
- Verify Firebase configuration is correct
- Check console logs for any error messages

**Developer Tools not showing?**
- Make sure you've imported the dev tools screen
- Check that the menu item was added to profile screen

**Seeding fails?**
- Ensure internet connection is stable
- Verify Firestore permissions in Firebase Console
- Check that the `.env` file contains valid Firebase credentials

---

**Happy seeding! 🌱** Your Sales Bets app now has professional, realistic data that makes it look like a legitimate business application.