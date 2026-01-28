import gifAnimation.*;

String[][] strs = new String[6][2];
PFont font;

// ====== 动画状态 ======
int i = 0;                 // 当前打到/删到第几个字符（两行共用同一个 i）
int s = 0;                 // 当前第几页
boolean deleting = false;  // 是否在删除阶段
boolean holding = false;   // 是否在停留阶段

// ====== 版式参数 ======
int offset = 50;
int mainFontSize = 60;
int secondaryFontSize = 40;

// ====== 停留时长：1.5s ======
int holdFrames = 45;       // 30fps * 1.5s = 45
int holdCounter = 0;

// ====== GIF 输出 ======
GifMaker gif;
boolean recordGif = true;  // 改成 false 就不录 gif

void setup() {
  size(1920, 1080);
  frameRate(30);

  font = createFont("Helvetica", 48);
  textFont(font);
  textAlign(CENTER, CENTER);
  fill(0);

  // ========== 页面 1 ==========
  strs[0][0] = "Hey there! (´▽`ʃ♡ƪ)";
  strs[0][1] = "I'm  Qi-007";

  // ========== 页面 2 ==========
  strs[1][0] = "a Student & Learner";
  strs[1][1] = "Always curious, always improving";

  // ========== 页面 3 ==========
  strs[2][0] = "Current Focus (੭ु´ ᐜ `)੭ु⁾⁾";
  strs[2][1] = "Linux, Computer Vision, Robotics, and Systems";

  // ========== 页面 4 ==========
  strs[3][0] = "Learning in Progress";
  strs[3][1] = "Turn ideas into reality";

  // ========== 页面 5 ==========
  strs[4][0] = "Let's Connect σ(´∀｀*)";
  strs[4][1] = "Open to collaborations and interesting projects";

  // ========== 页面 6（联系方式） ==========
  strs[5][0] = "Get in Touch";
  strs[5][1] = "GitHub: Qi-007 | Email: bannerqi007@gmail.com";

  // ====== 初始化 GIF ======
  if (recordGif) {
    gif = new GifMaker(this, "output.gif");
    gif.setRepeat(0);   // 0=无限循环
    gif.setDelay(33);   // 33ms ≈ 30fps
    // gif.setQuality(10); // 可选：数值越小质量越高但更大
  }
}

void draw() {
  background(255);

  if (s < strs.length) {
    String line1 = strs[s][0];
    String line2 = strs[s][1];

    // 这页需要打到的最大长度（两行取更长）
    int maxLen = max(line1.length(), line2.length());

    // ====== 1) 打字阶段 ======
    if (!deleting && !holding) {
      int showLen = min(i, maxLen);

      drawTwoLines(line1, line2, showLen);

      i++;

      // 两行都打完了 -> 进入停留
      if (i > maxLen) {
        holding = true;
        holdCounter = 0;
      }
    }

    // ====== 2) 停留阶段（1.5 秒） ======
    else if (holding) {
      drawTwoLines(line1, line2, maxLen);

      holdCounter++;
      if (holdCounter >= holdFrames) {
        holding = false;
        deleting = true;
        // 注意：此时 i 可能是 maxLen+1（因为上面 i++ 过）
        // 删除阶段会先 i-- 再显示，不影响观感
      }
    }

    // ====== 3) 删除阶段 ======
    else if (deleting) {
      i--;

      int showLen = max(0, min(i, maxLen));
      drawTwoLines(line1, line2, showLen);

      // 删到空了 -> 下一页，重置状态
      if (i <= 0) {
        deleting = false;
        s++;
        i = 0;
      }
    }
  }

  // ====== 录制 GIF ======
  if (recordGif) {
    gif.addFrame();

    // 所有页面播完就收尾
    if (s >= strs.length) {
      gif.finish();
      println("GIF saved: output.gif");
      exit();
    }
  }
}

// 画两行文本，len 表示当前显示到第几个字符（两行分别截断）
void drawTwoLines(String a, String b, int len) {
  int lenA = min(len, a.length());
  int lenB = min(len, b.length());

  textSize(mainFontSize);
  text(a.substring(0, lenA), width/2, height/2 - offset);

  textSize(secondaryFontSize);
  text(b.substring(0, lenB), width/2, height/2 + offset);
}
