String[][] strs = new String[6][2];
PFont font;

void setup() {
  size(1920, 1080);
  font = createFont("Helvetica", 48);
  textFont(font);
  frameRate(30);
  textAlign(CENTER);
  textSize(40);
  background(255);
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
}

int i = 0;
boolean delete = false;
int s = 0;
int offset = 50;
int mainFontSize = 60;
int secondaryFontSize = 40;

// ========== GIF 保存设置 ==========
boolean saveFrames = true;   // 改为 true 开始保存帧
int frameNum = 0;


void draw() {
  background(255);

  if (s < strs.length) {
    if ((strs[s][0].length() >= i || strs[s][1].length() >= i) && !delete) {
      if (strs[s][0].length() >= i) {
        textSize(mainFontSize);
        text(strs[s][0].substring(0, i), width/2, height/2 - offset);
      } else {
        textSize(mainFontSize);
        text(strs[s][0], width/2, height/2 - offset);
      }
      if (strs[s][1].length() >= i) {
        textSize(secondaryFontSize);
        text(strs[s][1].substring(0, i), width/2, height/2 + offset);
      } else {
        textSize(secondaryFontSize);
        text(strs[s][1], width/2, height/2 + offset);
      }
      i++;
    } else {
      if (!delete) {
        delay(1500);
      }
      delete = true;
    }


    if (delete) {

      if (i > 0) {
        if (i < strs[s][0].length()) {
          textSize(mainFontSize);
          text(strs[s][0].substring(0, i - 1), width/2, height/2 - offset);
        } else {
          textSize(mainFontSize);
          text(strs[s][0], width/2, height/2 - offset);
        }
        if (i < strs[s][1].length()) {
          textSize(secondaryFontSize);
          text(strs[s][1].substring(0, i - 1), width/2, height/2 + offset);
        } else {
          textSize(secondaryFontSize);
          text(strs[s][1], width/2, height/2 + offset);
        }
        i--;
      } else {
        delete = false;
        s++;
      }
    }
    //print(i + " ");
    //s++;

    // ========== 保存帧用于生成 GIF ==========
    if (saveFrames) {
      saveFrame("frames/frame####.png");
      frameNum++;
    }
  }
}
