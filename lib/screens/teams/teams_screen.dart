import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_bets/models/team/team_model.dart';
import 'package:sales_bets/screens/teams/cubit/teams_cubit.dart';
import '../../core/constants/app_constants.dart';
import '../../core/themes/app_theme.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  void initState() {
    context.read<TeamsCubit>().getTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeamsCubit, TeamsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Teams'),
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
          ),
          body: DefaultTabController(
            length: 2,
            child:
                state.status == TeamStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                      children: [
                        FadeInDown(
                          child: const TabBar(
                            labelColor: AppTheme.primaryColor,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: AppTheme.primaryColor,
                            tabs: [
                              Tab(text: 'All Teams'),
                              Tab(text: 'Leaderboard'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              FadeInLeft(
                                child: _buildTeamsList(teams: state.teams),
                              ),
                              FadeInRight(child: _buildLeaderboard()),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),
        );
      },
    );
  }

  Widget _buildTeamsList({required List<TeamModel> teams}) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildTeamListItem(team: teams[index]),
        );
      },
    );
  }

  Widget _buildTeamListItem({required TeamModel team}) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
            ),
            child: const Icon(Icons.group, color: Colors.white, size: 30),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team ${team.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${team.wins} wins • ${team.followers}K followers',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: AppConstants.smallSpacing),
                Row(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 8,
                    //     vertical: 4,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: AppTheme.successColor.withOpacity(0.1),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   child: const Text(
                    //     'Following',
                    //     style: TextStyle(
                    //       color: AppTheme.successColor,
                    //       fontSize: 12,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: AppConstants.smallSpacing),
                    if (team.isLive)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              color: AppTheme.errorColor,
                              size: 8,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'LIVE',
                              style: TextStyle(
                                color: AppTheme.errorColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      itemCount: 10,
      itemBuilder: (context, index) {
        return FadeInUp(
          delay: Duration(milliseconds: index * 100),
          child: _buildLeaderboardItem(index),
        );
      },
    );
  }

  Widget _buildLeaderboardItem(int index) {
    final rank = index + 1;
    Color rankColor = Colors.grey;

    if (rank == 1) rankColor = Colors.amber;
    if (rank == 2) rankColor = Colors.grey[400]!;
    if (rank == 3) rankColor = Colors.brown;

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        border: rank <= 3 ? Border.all(color: rankColor, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: rankColor, shape: BoxShape.circle),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
            ),
            child: const Icon(Icons.group, color: Colors.white, size: 25),
          ),
          const SizedBox(width: AppConstants.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team ${String.fromCharCode(65 + index)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${(10 - index) * 1250} credits earned',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${(10 - index) * 25} wins',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.successColor,
                ),
              ),
              Text(
                '${index * 5} losses',
                style: const TextStyle(color: AppTheme.errorColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
