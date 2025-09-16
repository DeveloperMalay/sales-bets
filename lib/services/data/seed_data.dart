import '../../models/team/team_model.dart';
import '../../models/event/event_model.dart';
import '../../models/stream/stream_model.dart';

class SeedData {
  // Realistic sales team names with different company types
  static final List<TeamModel> teams = [
    TeamModel(
      id: 'team1',
      name: 'Revenue Riders',
      description: 'Enterprise software sales team specializing in SaaS solutions',
      wins: 23,
      followers: 4782,
      totalEarnings: 2840000,
      logoUrl: 'https://via.placeholder.com/150/0066CC/FFFFFF?text=RR',
      createdAt: DateTime.now().subtract(const Duration(days: 180)),
    ),
    TeamModel(
      id: 'team2',
      name: 'Quota Crushers',
      description: 'High-performing B2B sales professionals in the fintech space',
      wins: 31,
      followers: 6234,
      totalEarnings: 3650000,
      logoUrl: 'https://via.placeholder.com/150/FF6B35/FFFFFF?text=QC',
      createdAt: DateTime.now().subtract(const Duration(days: 220)),
    ),
    TeamModel(
      id: 'team3',
      name: 'Deal Dynamos',
      description: 'Healthcare technology sales experts closing complex deals',
      wins: 18,
      followers: 3456,
      totalEarnings: 2100000,
      logoUrl: 'https://via.placeholder.com/150/7B68EE/FFFFFF?text=DD',
      createdAt: DateTime.now().subtract(const Duration(days: 95)),
    ),
    TeamModel(
      id: 'team4',
      name: 'Pipeline Pioneers',
      description: 'Marketing automation specialists driving lead generation',
      wins: 27,
      followers: 5123,
      totalEarnings: 3200000,
      logoUrl: 'https://via.placeholder.com/150/00CED1/FFFFFF?text=PP',
      createdAt: DateTime.now().subtract(const Duration(days: 145)),
    ),
    TeamModel(
      id: 'team5',
      name: 'Closing Champions',
      description: 'Insurance sales team with proven track record',
      wins: 21,
      followers: 2987,
      totalEarnings: 1850000,
      logoUrl: 'https://via.placeholder.com/150/FF1493/FFFFFF?text=CC',
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
    ),
    TeamModel(
      id: 'team6',
      name: 'Sales Spartans',
      description: 'Real estate professionals dominating residential markets',
      wins: 15,
      followers: 4321,
      totalEarnings: 2750000,
      logoUrl: 'https://via.placeholder.com/150/32CD32/FFFFFF?text=SS',
      createdAt: DateTime.now().subtract(const Duration(days: 88)),
    ),
    TeamModel(
      id: 'team7',
      name: 'Territory Titans',
      description: 'Manufacturing sales reps covering industrial accounts',
      wins: 19,
      followers: 3678,
      totalEarnings: 2300000,
      logoUrl: 'https://via.placeholder.com/150/FF8C00/FFFFFF?text=TT',
      createdAt: DateTime.now().subtract(const Duration(days: 167)),
    ),
    TeamModel(
      id: 'team8',
      name: 'Commission Kings',
      description: 'Luxury automotive sales team with premium client base',
      wins: 12,
      followers: 5876,
      totalEarnings: 4200000,
      logoUrl: 'https://via.placeholder.com/150/8A2BE2/FFFFFF?text=CK',
      createdAt: DateTime.now().subtract(const Duration(days: 134)),
    ),
  ];

  // Realistic sales events and challenges
  static final List<EventModel> events = [
    EventModel(
      id: 'event1',
      title: 'Q1 Revenue Challenge',
      description: 'Who will hit the highest quarterly revenue? Teams compete to maximize sales performance in the first quarter.',
      teamIds: ['team1', 'team2', 'team4'],
      startTime: DateTime.now().add(const Duration(hours: 3)),
      endTime: DateTime.now().add(const Duration(days: 90)),
      status: EventStatus.upcoming,
      streamUrl: 'https://stream.salesbets.com/q1-revenue',
      bannerImageUrl: 'https://via.placeholder.com/800x400/0066CC/FFFFFF?text=Q1+Revenue+Challenge',
      odds: {'team1': 2.1, 'team2': 1.8, 'team4': 2.4},
      totalBetsPlaced: 234,
      totalCreditsWagered: 45600,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    EventModel(
      id: 'event2',
      title: 'Cold Call Championship',
      description: 'The ultimate test of prospecting skills. Teams compete to book the most qualified meetings through cold outreach.',
      teamIds: ['team3', 'team5', 'team7'],
      startTime: DateTime.now().subtract(const Duration(minutes: 45)),
      endTime: DateTime.now().add(const Duration(days: 14)),
      status: EventStatus.live,
      streamUrl: 'https://stream.salesbets.com/cold-call-championship',
      bannerImageUrl: 'https://via.placeholder.com/800x400/FF6B35/FFFFFF?text=Cold+Call+Championship',
      odds: {'team3': 3.2, 'team5': 2.7, 'team7': 2.1},
      totalBetsPlaced: 567,
      totalCreditsWagered: 89300,
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
    ),
    EventModel(
      id: 'event3',
      title: 'Enterprise Deal Derby',
      description: 'Major account showdown! Teams race to close the largest enterprise deals. Minimum deal size: \$50K.',
      teamIds: ['team1', 'team6', 'team8'],
      startTime: DateTime.now().add(const Duration(days: 2)),
      endTime: DateTime.now().add(const Duration(days: 45)),
      status: EventStatus.upcoming,
      streamUrl: 'https://stream.salesbets.com/enterprise-derby',
      bannerImageUrl: 'https://via.placeholder.com/800x400/7B68EE/FFFFFF?text=Enterprise+Deal+Derby',
      odds: {'team1': 1.9, 'team6': 2.8, 'team8': 2.3},
      totalBetsPlaced: 123,
      totalCreditsWagered: 28900,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    EventModel(
      id: 'event4',
      title: 'New Client Acquisition Sprint',
      description: 'Two-week intensive competition to onboard the most new clients. Quality and quantity both matter.',
      teamIds: ['team2', 'team4', 'team5'],
      startTime: DateTime.now().add(const Duration(days: 7)),
      endTime: DateTime.now().add(const Duration(days: 21)),
      status: EventStatus.upcoming,
      streamUrl: 'https://stream.salesbets.com/client-sprint',
      bannerImageUrl: 'https://via.placeholder.com/800x400/00CED1/FFFFFF?text=New+Client+Sprint',
      odds: {'team2': 2.0, 'team4': 2.2, 'team5': 2.6},
      totalBetsPlaced: 89,
      totalCreditsWagered: 15400,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    EventModel(
      id: 'event5',
      title: 'Referral Network Bonanza',
      description: 'Generate the most qualified referrals from existing customers. Relationship building at its finest.',
      teamIds: ['team3', 'team6', 'team7'],
      startTime: DateTime.now().subtract(const Duration(days: 3)),
      endTime: DateTime.now().add(const Duration(days: 25)),
      status: EventStatus.live,
      streamUrl: 'https://stream.salesbets.com/referral-bonanza',
      bannerImageUrl: 'https://via.placeholder.com/800x400/FF1493/FFFFFF?text=Referral+Bonanza',
      odds: {'team3': 2.4, 'team6': 1.7, 'team7': 3.1},
      totalBetsPlaced: 445,
      totalCreditsWagered: 72100,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    EventModel(
      id: 'event6',
      title: 'Demo Conversion Masters',
      description: 'From demo to deal! Teams compete to achieve the highest demo-to-close conversion rate.',
      teamIds: ['team1', 'team3', 'team8'],
      startTime: DateTime.now().add(const Duration(hours: 18)),
      endTime: DateTime.now().add(const Duration(days: 30)),
      status: EventStatus.upcoming,
      streamUrl: 'https://stream.salesbets.com/demo-masters',
      bannerImageUrl: 'https://via.placeholder.com/800x400/32CD32/FFFFFF?text=Demo+Conversion+Masters',
      odds: {'team1': 1.6, 'team3': 2.9, 'team8': 2.2},
      totalBetsPlaced: 178,
      totalCreditsWagered: 31200,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  // Live streams for the events
  static final List<StreamModel> streams = [
    StreamModel(
      id: 'stream1',
      title: 'Q1 Revenue Challenge - Live Leaderboard',
      description: 'Watch real-time revenue updates as teams battle for quarterly supremacy',
      teamId: 'team1',
      eventId: 'event1',
      streamUrl: 'https://stream.salesbets.com/q1-revenue',
      thumbnailUrl: 'https://via.placeholder.com/400x225/0066CC/FFFFFF?text=Q1+Revenue+Live',
      viewerCount: 2847,
      isLive: true,
      streamerName: 'Sales Arena',
      startedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    StreamModel(
      id: 'stream2',
      title: 'Cold Call Championship Finals',
      description: 'The most intense cold calling session you\'ve ever seen - live coaching included',
      teamId: 'team3',
      eventId: 'event2',
      streamUrl: 'https://stream.salesbets.com/cold-call-championship',
      thumbnailUrl: 'https://via.placeholder.com/400x225/FF6B35/FFFFFF?text=Cold+Call+Live',
      viewerCount: 1923,
      isLive: true,
      streamerName: 'Prospecting Pro',
      startedAt: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    StreamModel(
      id: 'stream3',
      title: 'Pipeline Pioneers Training Session',
      description: 'Behind-the-scenes look at how the Pipeline Pioneers prepare for competitions',
      teamId: 'team4',
      streamUrl: 'https://stream.salesbets.com/pipeline-training',
      thumbnailUrl: 'https://via.placeholder.com/400x225/00CED1/FFFFFF?text=Training+Session',
      viewerCount: 856,
      isLive: true,
      streamerName: 'Pipeline Pioneers',
      startedAt: DateTime.now().subtract(const Duration(minutes: 20)),
    ),
    StreamModel(
      id: 'stream4',
      title: 'Referral Network Workshop',
      description: 'Learn the secrets of building powerful referral networks from the pros',
      teamId: 'team6',
      eventId: 'event5',
      streamUrl: 'https://stream.salesbets.com/referral-workshop',
      thumbnailUrl: 'https://via.placeholder.com/400x225/FF1493/FFFFFF?text=Referral+Workshop',
      viewerCount: 1234,
      isLive: false,
      streamerName: 'Network Ninja',
      startedAt: DateTime.now().subtract(const Duration(hours: 4)),
      endedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    StreamModel(
      id: 'stream5',
      title: 'Commission Kings Luxury Sales Masterclass',
      description: 'High-end sales techniques for luxury products and premium clients',
      teamId: 'team8',
      streamUrl: 'https://stream.salesbets.com/luxury-masterclass',
      thumbnailUrl: 'https://via.placeholder.com/400x225/8A2BE2/FFFFFF?text=Luxury+Sales',
      viewerCount: 567,
      isLive: false,
      streamerName: 'Luxury Sales Expert',
      startedAt: DateTime.now().subtract(const Duration(days: 1)),
      endedAt: DateTime.now().subtract(const Duration(hours: 22)),
    ),
  ];

  // Get active/live events
  static List<EventModel> getLiveEvents() {
    return events.where((event) => event.status == EventStatus.live).toList();
  }

  // Get upcoming events
  static List<EventModel> getUpcomingEvents() {
    return events.where((event) => event.status == EventStatus.upcoming).toList();
  }

  // Get top performing teams by wins
  static List<TeamModel> getTopTeams({int limit = 6}) {
    final sortedTeams = List<TeamModel>.from(teams);
    sortedTeams.sort((a, b) => b.wins.compareTo(a.wins));
    return sortedTeams.take(limit).toList();
  }

  // Get teams by followers (trending)
  static List<TeamModel> getTrendingTeams({int limit = 6}) {
    final sortedTeams = List<TeamModel>.from(teams);
    sortedTeams.sort((a, b) => b.followers.compareTo(a.followers));
    return sortedTeams.take(limit).toList();
  }

  // Get live streams
  static List<StreamModel> getLiveStreams() {
    return streams.where((stream) => stream.isLive).toList();
  }

  // Get team by ID
  static TeamModel? getTeamById(String id) {
    try {
      return teams.firstWhere((team) => team.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get teams for event
  static List<TeamModel> getTeamsForEvent(EventModel event) {
    return teams.where((team) => event.teamIds.contains(team.id)).toList();
  }

  // Get random teams for new events (useful for generating more events)
  static List<String> getRandomTeamIds({int count = 3}) {
    final shuffledTeams = List<TeamModel>.from(teams)..shuffle();
    return shuffledTeams.take(count).map((team) => team.id).toList();
  }
}