// ------------------------------------------------------
class Timer
{
  float now, before;
  Timer()
  {
    now = before = millis();
  }

  float update()
  {
    now = millis();
    float dt = now-before;
    before = now;
    
    return dt/1000.0f;
  }
}