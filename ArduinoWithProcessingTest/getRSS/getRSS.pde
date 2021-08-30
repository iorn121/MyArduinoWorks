// Arduinoネットワークランプ

import processing.serial.*;
import java.net.*;
import java.io.*;
import java.util.*;


String feed = "https://blog.arduino.cc/feed/";

int interval = 5*60*1000; // フィードを取得する感覚
int lastTime; // 最後に取得した時間
int love = 0;
int peace = 0;
int arduino = 0;
int light = 0; // Arduinoで測った明るさ

Serial port;
color c;
String cs;

String buffer = ""; // Arduinoからの文字を記録
PFont font;

void setup() {
  size(640,480);
  frameRate(10);

  font = createFont("Helvetica",24);
  fill(25);
  textFont(font, 32);

  // println(Serial.list());
  String arduinoPort = Serial.list()[Serial.list().length-2];

  // Arduinoに接続
  port = new Serial(this, arduinoPort, 9600);

  lastTime=millis();
  fetchData();
}

void draw() {
  background(c);
  int n = (lastTime + interval - millis()/1000);

  // 3つの色を参考に色を作成
  c = color(peace, love, arduino);
  cs = "#" + hex(c, 6);

  text("Arduino Network Lamp", 10, 40);
  text("Reading feed:", 10, 100);
  text(feed, 10, 140);

  text("Next Update in " + n + " seconds", 10, 450);
  text("peace", 10, 200);
  text(" " + peace, 130, 200);
  rect(200, 172, peace, 28);

  text("love ", 10, 240);
  text(" " + love, 130, 240);
  rect(200, 212, love, 28);

  text("arduino ", 10, 280);
  text(" " + arduino, 130, 280);
  rect(200, 252, arduino, 28);

  // 画面に色情報を表示
  text("sending", 10, 340);
  text(cs, 200, 340);

  text("light level", 10, 380);
  rect(200, 352, light/10.23, 28);

  if(n <= 0) {
    fetchData();
    lastTime = millis();
  }

  // Arduinoにデータを送る
  port.write(cs);

  if(port.available() > 0) {
    int inByte = port.read();
    if(inByte != 10) {
      buffer = buffer + char(inByte);
    } else {
      // new ¥lineが届いたのでデータを処理しましょう
      if(buffer.length()>1) {
        buffer = buffer.substring(0, buffer.length()-1);
        light = int(buffer);
        buffer="";
        port.clear();
      }
    }
  }
}

void fetchData() {
  String data;
  String chunk;

  love = 0;
  peace =0;
  arduino = 0;

  try {
    URL url = new URL(feed);
    URLConnection conn = url.openConnection();
    conn.connect();

    BufferedReader in = new BufferedReader(
      new InputStreamReader(conn.getInputStream())
    );
    while((data=in.readLine()) != null) {
      StringTokenizer st = new StringTokenizer(data, "\"<>,.()[] ");
      while(st.hasMoreTokens()) {
        chunk = st.nextToken().toLowerCase();
        if(chunk.indexOf("love")>=0) love++;
        if(chunk.indexOf("peace")>=0) peace++;
        if(chunk.indexOf("arduino")>=0) arduino++;
      }
    }
    if ( peace>64) peace = 64;
    if ( love>64) love = 64;
    if ( arduino>64) arduino = 64;
    peace = peace*4;
    love = love*4;
    arduino = arduino*4;
  }
  catch (Exception e) {
    e.printStackTrace();
    System.out.println("ERROR: " +e.getMessage());
  }
}
