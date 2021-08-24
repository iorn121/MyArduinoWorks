
const int LED = 9;
const int BUTTON = 7;

int val = 0;
int old_val = 0;
int state = 0;

int brightness = 128;
unsigned long startTime = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED,OUTPUT);
  pinMode(BUTTON,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  val = digitalRead(BUTTON);

  // 変化があるか
  if ((val==HIGH)&&(old_val==LOW)) {
    // 状態を切り替える 
    state = 1 - state;
    // 時間計測開始
    startTime = millis();

    delay(10);
  }

  // ボタンが押し続けられているか
  if ((val==HIGH)&&(old_val==HIGH)) {
    // 点灯かつ500ms以上経過しているか
    if (state==1&&(millis()-startTime)>=500) {
      // 明るくする
      brightness++;
      delay(10);
      // 255を超えたら0に戻す
      if(brightness > 255) {
        brightness = 0;
      }
    }
  }

  // 処理後のvalを記録する
  old_val = val;

  if (state==1) {
    analogWrite(LED,brightness);
  } else {
    analogWrite(LED,0);
  }
}
