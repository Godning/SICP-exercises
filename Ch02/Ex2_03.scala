/**
  * Ex2_03.scala
  * Kevin C. Baird
  * SICP in Scala (http://www.scala-lang.org/documentation/)
  *
  * Represent rectangles on a plane
  */

case class Point(x: Double, y: Double) {
  override def toString(): String = "(" + x + ", " + y + ")";
}

case class Rectangle(ul: Point, ur: Point, ll: Point, lr: Point) {
  override def toString(): String = "(" + ul + ", " + ur + ", " + ll + ", " + lr + ")";

  def area:      Double = { _top * _side }
  def perimeter: Double = { (_top + _side) * 2.0 }

  private def _side: Double = { _distance(ul, ur) }
  private def _top:  Double = { _distance(ur, lr) }
  private def _distance(pt1: Point, pt2: Point): Double = {
    /*
    square   = (x) -> x * x
    xDiff    = (pt1, pt2) -> (pt2.x - pt1.x)
    yDiff    = (pt1, pt2) -> (pt2.y - pt1.y)
    xSquares = square(xDiff(pt1, pt2))
    ySquares = square(yDiff(pt1, pt2))
    Math.sqrt(xSquares + ySquares)
    */
    1.5
  }
}

def output() = {
  val ul   = new Point(0.0, 4.0)
  val ur   = new Point(3.0, 4.0)
  val ll   = new Point(0.0, 0.0)
  val lr   = new Point(3.0, 0.0)
  val rect = new Rectangle(ul, ur, ll, lr)
  (rect.perimeter, rect.area)
}

/**
  * execute with
  * scala -i Ex2_03.scala -e "println(output)"
  * until I figure out a better way
  */

