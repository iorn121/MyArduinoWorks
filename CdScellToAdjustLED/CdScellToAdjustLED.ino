const int LED = 9;
int val = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(LED,OUTPUT); // LEDに出力
  // アナログピンは自動的に入力として受け取る
}

void loop() {
  // put your main code here, to run repeatedly:
  val = analogRead(0); // センサから読み取る

  analogWrite(LED, val/2); // センサの値を明るさにして点灯
  delay(10);
}
