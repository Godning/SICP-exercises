#!/usr/bin/env /ruby
# ex2_07-10.rb

=begin rdoc
Kevin C. Baird
SICP in Ruby
Exercise 2.7  - Interval Arithmetic
Exercise 2.8  - Add subtraction
Exercise 2.9  - Add width
Exercise 2.10 - Add spans_zero? error handling
=end

require 'rspec'

class Range

  def +(other_range)
    new_first = (first + other_range.first)
    new_last  = (last  + other_range.last)
    new_first..new_last
  end

  def -(other_range)
    new_first = (first - other_range.first)
    new_last  = (last  - other_range.last)
    new_first..new_last
  end

  def *(other_range)
    p1 = first * other_range.first
    p2 = first * other_range.last
    p3 = last  * other_range.first
    p4 = last  * other_range.last
    new_first = [p1, p2, p3, p4].min
    new_last  = [p1, p2, p3, p4].max
    new_first..new_last
  end

  # Ex2.11 version, testing signs
  def mult(other_range)
    xlo = first
    xhi = last
    ylo = other_range.first
    yhi = other_range.last
    pos = ->(x) { x >= 0 }
    neg = ->(x) { x <= 0 }
    return (xlo * ylo)..(xhi * yhi) if [xlo, xhi, ylo, yhi].all?(&pos)
    return (xhi * ylo)..(xhi * yhi) if [xlo, xhi, yhi].all?(&pos) and [ylo].all?(&neg)
    return (xhi * ylo)..(xlo * yhi) if [xlo, xhi].all?(&pos) and [ylo, yhi].all?(&neg)
    return (xlo * yhi)..(xhi * ylo) if [xlo].all?(&neg) and [xhi, ylo, yhi].all?(&pos)
    if [xlo, ylo].all?(&neg) and [xhi, yhi].all?(&pos)
      new_min = [(xhi * ylo), (xlo * yhi)].min
      new_max = [(xlo * ylo), (xhi * yhi)].min
      return new_min..new_max
    end
    return (xhi * ylo)..(xlo * ylo) if [xhi].all?(&pos) and [xlo, ylo, yhi].all?(&pos)
    return (xlo * yhi)..(xhi * ylo) if [xlo, xhi].all?(&neg) and [ylo, yhi].all?(&pos)
    return (xlo * yhi)..(xlo * ylo) if [xlo, xhi, ylo].all?(&neg) and [yhi].all?(&pos)
    return (xhi * yhi)..(xlo * ylo) if [xlo, xhi, ylo, yhi].all?(&pos)
  end

  def /(other_range)
    raise ZeroDivisionError if other_range.spans_zero?
    recip = (1.0 / other_range.last)..(1.0 / other_range.first)
    self * recip
  end

  def width
    (last - first) / 2.0
  end

  protected

  def spans_zero?
    (first >= 0 and last <= 0) or
    (first <= 0 and last >= 0)
  end

end

describe Range do
  r1 = (0..9)
  r2 = (3..5)
  r3 = (0..1)
  describe "#{r1} + #{r2}" do
    subject { r1 + r2 }
    it { should eq((3..14)) }
  end
  describe "#{r1} - #{r2}" do
    subject { r1 - r2 }
    it { should eq((-3..4)) }
  end
  describe "#{r1} * #{r2}" do
    subject { r1 * r2 }
    it { should eq((0..45)) }
  end
  describe "#{r1}.mult(#{r2})" do
    subject { r1.mult(r2) }
    it { should eq((0..45)) }
  end
  describe "#{r1} / #{r2}" do
    subject { r1 / r2 }
    it { should eq((0..3)) }
  end
  describe "#{r1} / #{r3}" do
    division_by_zero = -> { r1 / r3 }
    it "raises a div by zero error" do
      expect(division_by_zero).to raise_error(ZeroDivisionError)
    end
  end
  describe "#{r1}.width" do
    subject { r1.width }
    it { should eq(4.5) }
  end
  describe "#{r2}.width" do
    subject { r2.width }
    it { should eq(1) }
  end
end
