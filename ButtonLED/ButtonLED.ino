//  ボタンを押すとLEDが点灯し、指を離しても点灯し続ける

const int LED = 13;
const int BUTTON = 7;

int val = 0;
int old_val = 0;
int state = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED, OUTPUT);
  pinMode(BUTTON, INPUT);
}

void loop() {
//  常に新しい入力を受け取る
  val = digitalRead(BUTTON);
//　ボタンの状態変化があればLEDのステータスを変化させる
  if ((old_val==LOW) && (val==HIGH)) {
    state = 1 - state;
    delay(10);
  }
//  古くなったvalはold_valに
  old_val = val;

  if(state==1) {
    digitalWrite(LED, HIGH);
  } else {
    digitalWrite(LED, LOW);
  }
}
