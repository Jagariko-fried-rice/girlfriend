import 'package:flutter/material.dart';
import '../models/story_segment.dart';
import 'girlfriend_setup_screen.dart';

class LifeMemoryScreen extends StatelessWidget {
  final GirlfriendConfig girlfriendConfig;
  final List<StorySegment> storySegments;
  final Color accentColor;

  const LifeMemoryScreen({
    super.key,
    required this.girlfriendConfig,
    required this.storySegments,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFEBF3), Color(0xFFFFF5F9)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFE4F0),
                        Color(0xFFEDE7FF),
                        Color(0xFFCFE4FF),
                      ],
                    ),
                  ),
                ),
              ),
              _buildContent(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.arrow_back),
                color: const Color(0xFFB91C1C),
              ),
              IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(Icons.close),
                color: const Color(0xFFB91C1C),
              ),
            ],
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              radius: const Radius.circular(12),
              thickness: 6,
              child: SingleChildScrollView(
                primary: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    _buildHeader(),
                    const SizedBox(height: 20),
                    ...storySegments
                        .map((segment) => _buildSegmentCard(context, segment))
                        .toList(),
                    const SizedBox(height: 24),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${girlfriendConfig.name}の人生',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xFFB91C1C),
            shadows: [
              Shadow(
                color: Color(0x33B91C1C),
                blurRadius: 20,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Sleep Dive Memory Log',
          style: TextStyle(fontSize: 14, color: Color(0xFFB91C1C)),
        ),
      ],
    );
  }

  Widget _buildSegmentCard(BuildContext context, StorySegment segment) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => _showSegmentDetail(context, storySegments.indexOf(segment)),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFFFF8FB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white70),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40FF69B4),
              blurRadius: 22,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [accentColor, Colors.pink.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  segment.imageEmoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${segment.age}歳',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFB91C1C),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    segment.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB91C1C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    segment.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4C1D95),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSegmentDetail(BuildContext context, int startIndex) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            final pageController = PageController(initialPage: startIndex);
            int currentIndex = startIndex;
            return StatefulBuilder(builder: (context, setState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: currentIndex > 0
                                ? () async {
                                    await pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_back_ios),
                            color: currentIndex > 0 ? const Color(0xFFB91C1C) : Colors.grey,
                          ),
                          Text('${currentIndex + 1}/${storySegments.length}', style: const TextStyle(color: Color(0xFFB91C1C))),
                          IconButton(
                            onPressed: currentIndex < storySegments.length - 1
                                ? () async {
                                    await pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                  }
                                : null,
                            icon: const Icon(Icons.arrow_forward_ios),
                            color: currentIndex < storySegments.length - 1 ? const Color(0xFFB91C1C) : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: storySegments.length,
                        onPageChanged: (i) => setState(() => currentIndex = i),
                        itemBuilder: (context, index) {
                          final segment = storySegments[index];
                          return SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [accentColor, Colors.pink.shade200],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      segment.imageEmoji,
                                      style: const TextStyle(fontSize: 36),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  segment.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB91C1C),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${segment.age}歳',
                                  style: const TextStyle(color: Color(0xFFB91C1C)),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  segment.description,
                                  style: const TextStyle(fontSize: 16, color: Color(0xFF4C1D95)),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: accentColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(ctx).pop(),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      child: Text('閉じる', style: TextStyle(fontSize: 16)),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }


  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFB6C1)),
      ),
      child: const Text(
        '継続的な睡眠で彼女の記憶を耕し続けよう。',
        textAlign: TextAlign.center,
        style: TextStyle(color: Color(0xFF4C1D95), fontSize: 12),
      ),
    );
  }
}
