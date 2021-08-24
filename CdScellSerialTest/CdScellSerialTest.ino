// アナログ入力ピン0の値をコンピュータへ送る
// アップロードの後に、「Serial Monitor」ボタンを押すこと

const int SENSOR = 0; // 抵抗型のセンサが繋がっているピン
int val = 0; // センサからの値を記録する変数

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600); // シリアルポートを開いて毎秒9600bitでコンピュータにデータ送信
}

void loop() {
  // put your main code here, to run repeatedly:
  val = analogRead(SENSOR); // センサから値を取得
  Serial.println(val);
  delay(100);
}
