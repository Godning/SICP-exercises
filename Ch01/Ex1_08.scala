/**
  * Ex1_08.scala
  * Kevin C. Baird
  * SICP in Scala (http://www.scala-lang.org/documentation/)
  *
  * Calculate cube roots using Newton's Method
  * (Exercise 1.8)
  */

object NewtonCube extends App {

  def cbrt(x: Double) = { cbrtIter(1.0, x) } /* TODO: figure out point-free */

  def improve(guess: Double, x: Double) = {
    (x / (square(guess)) + (2 * guess)) / 3.0
  }

  def goodEnough(guess: Double, x: Double) = {
    (math.abs((cube(guess)) - x)) < tolerance
  }

  def square(x: Double) = { x * x }
  def cube(x: Double)   = { x * x * x }

  def tolerance() = { 0.001 } /* TODO: Constant */

  def cbrtIter(guess: Double, x: Double): Double = {
    goodEnough(guess, x) match {
      case true  => guess
      case false => cbrtIter(improve(guess, x), x)
    }
  }
}

/**
  * execute with
  * scala -i Ex1_08.scala -e "println(NewtonCube.cbrt(2.0))"
  * until I figure out a better way
  */
