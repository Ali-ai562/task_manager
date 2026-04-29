
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Controller/all_provider.dart';
import 'package:task_manager/views/add%20task/add_task_page.dart';
import 'package:task_manager/views/home/all/all_tasks.dart';
import 'package:task_manager/views/home/completed/completed_tasks.dart';
import 'package:task_manager/views/home/pending/pending_tasks.dart';
import 'package:task_manager/widgets/float_button.dart';
import 'package:task_manager/widgets/my_field.dart';
import 'package:task_manager/widgets/my_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  final List<String> _tabs = ['All', 'Pending', 'Completed'];
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AllProvider>();
    provider.searchTasks(_searchCtrl.text);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Header ──
                  MyText(
                    text: 'My Tasks',
                    size: 30,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  MyText(
                    text: _greeting,
                    size: 16,
                    weight: FontWeight.w400,
                    color: Colors.white54,
                  ),

                  const SizedBox(height: 20),

                  // ── Search ──
                  MyField(
                    controller: _searchCtrl,
                    hint: 'Search',
                    onTap: () {},
                    icon: Icons.search,
                    onChanged: (_) => setState(() {}),
                  ),

                  const SizedBox(height: 12),

                  // ── Tabs ──
                  Container(
                    height: 44,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF141414),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF2A2A2A)),
                    ),
                    child: Row(
                      children: List.generate(_tabs.length, (index) {
                        final isSelected = _selectedTab == index;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedTab = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFFE8C547)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Center(
                                child: Text(
                                  _tabs[index],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.black
                                        : const Color(0xFF888888),
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Task List ──
                  Expanded(child: _buildTabContent(provider)),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatButton(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  Widget _buildTabContent(AllProvider provider) {
    final query = _searchCtrl.text;

    switch (_selectedTab) {
      case 0:
        return AllTasks(tasks: provider.searchTasks(query));
      case 1:
        return PendingTasks(tasks: provider.searchPendingTasks(query));
      case 2:
        return CompletedTasks(tasks: provider.searchCompletedTasks(query));
      default:
        return const SizedBox();
    }
  }
}
