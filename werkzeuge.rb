#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Filename:  werkzeuge.rb
# Description:  Monkey Patches und Werkzeuge
# Version:  12.11.2016
# Created:  12.01.2015
# Revision:  none
# Language: Ruby >= 2.1.5 
# ------------------------------------------------------------------------
# Author: Sascha K. Biermanns, <skbierm AT gmail PUNKT com>
# Lizenz: GPL v3
# Copyright (C) 2011-2016 Sascha K. Biermanns
# This program is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 3 of the License, or (at your
# option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, see <http://www.gnu.org/licenses/>. 
# ------------------------------------------------------------------------


require 'prime'


############################
# Monkey Patches für Float #
############################


class Float
  def reverse
    to_s.reverse.to_f
  end

  alias :rückwärts :reverse
end


##############################
# Monkey Patches für Integer #
##############################


class Integer

  def abundant?
    if echte_teiler.inject(:+) > self
      return true
    else
      return false
    end
  end

  def befreundet?
    bz = echte_teiler.inject(:+)
    self == bz.echte_teiler.inject(:+) and self != bz
  end

  alias :amicable? :befreundet?
  
  def collatz
    sequenz = [self]
    until sequenz.last == 1
      if sequenz.last.even?
        sequenz.push(sequenz.last/2)
      else
        sequenz.push(3 * sequenz.last + 1)
      end
    end
    sequenz
  end

  def defizient?
    echte_teiler.inject(:+) < self
  end

  alias :deficient? :defizient?
  
  def dreieckszahl?
    wert = Math.sqrt(1 + (8 * self))
    wert == wert.to_i
  end

  alias :triangle_number? :dreieckszahl?

  def echte_teiler
    teiler(false)
  end

  alias :proper_divisors :echte_teiler
  
  def faktorisiere
    f = 1
    for i in 1..self
      f *= i
    end
    f
  end

  alias :factorize :faktorisiere

  def fibonacci_bis
    a, b = 0, 1
    menge = []
    until b > self
      menge << b
      a, b = b, a+b
    end
    return menge
  end
  
  
  def fünfeckszahl?
    wert = (1 + Math.sqrt(24 * self + 1)) / 6
    wert == wert.to_i
  end

  alias :pentagonal_number? :fünfeckszahl?
  

  def links_trunkierbare_primzahl?
    return false unless Prime.prime?(self)
    if self > 10
      to_s[1..-1].to_i.links_trunkierbare_primzahl?
    else
      return true
    end
  end

  alias :left_truncable_prime? :links_trunkierbare_primzahl?
  def lychrel?(suchtiefe=50)
    if self == self.reverse
      return false
    elsif suchtiefe == 0
      return true
    else
      (self + self.reverse).lychrel?(suchtiefe - 1)
    end
  end

  def pandigital?
    if self < 0
      return false
    end
    s = self.to_s
    sl = s.length
    set = s.chars.to_set
    set.count == sl && set == ("0"...sl.to_s).to_set || set == ("1"..sl.to_s).to_set
  end
 
  def phi
    1 if self == 1 else self.teiler.count - 1
  end

  def rechts_trunkierbare_primzahl?
    return false unless Prime.prime?(self)
    if self > 10
      (self/10).rechts_trunkierbare_primzahl?
    else
      return true
    end
  end

  alias :right_truncable_prime? :rechts_trunkierbare_primzahl?
  
  def rückwärts
    to_s.reverse.to_i
  end

  alias :reverse :rückwärts

  def summiere_ziffern
    to_s.split(//).inject(0) { | z, x| z + x.to_i }
  end

  alias :add_digits :summiere_ziffern

  def teiler(mit_letzter=true)
    unten, oben = [],[]
    (1..(Math.sqrt(self).to_i)).each do |i|
      if self%i == 0
        unten << i
        oben.unshift(self/i)
      end
    end
    unless mit_letzter
      oben.pop
    end
    unten + oben
  end

  alias :divisors :teiler
  
  def trunkierbare_primzahl?
    return links_trunkierbare_primzahl? && rechts_trunkierbare_primzahl?
  end

  alias :truncable_prime? :trunkierbare_primzahl?
  
  def vollkommen?
    self == echte_teiler.inject(:+)
  end

  alias :perfect? :vollkommen?
  
  def zirkuläre_primzahl?
    def rotiere(n)
      ziffern = n.to_s.chars
      ziffern.map do
        ziffern.rotate!.join.to_i
      end
    end
    rotiere(self).all? { |i| Prime.prime?(i) }
  end

  alias :circular_prime? :zirkuläre_primzahl?
end


##############################
# Monkey Patches für Numeric #
##############################


class Numeric
  def palindrom?
    to_s.palindrom?
  end

  def permutation?(x)
    to_s.permutation?(x.to_s)
  end

  def quadratzahl?
    self == Math.sqrt(self)**2
  end

  alias :square_number? :quadratzahl?
end


#############################
# Monkey Patches für String #
#############################


class String
  def palindrom?
    self == reverse
  end

  def permutation?(x)
    chars.sort.join == x.chars.sort.join
  end
end


#############################
# Unterstützende Funktionen #
#############################

def dreieckszahl(n)
  (n * (n+1) / 2).to_i
end

def fibonacci(n)
    a, b = 0, 1
    counter = 0
    until counter == n do
        a, b = b, a+b
        counter += 1
    end
    return a
end

def fibonacci_bis(n)
  a, b = 0, 1
  menge = []
  until b > n
    menge << b
    a, b = b, a+b
  end
  return menge
end

def fibonacci_generator
    a, b = 0, 1
    loop do
        yield a
        a, b = b, a+b
    end
end

def fünfeckszahl(n)
  (n * (3 * n - 1) / 2).to_i
end

def mersenne_zahl(n)
  n**2-1
end



