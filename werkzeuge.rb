#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Filename:  werkzeuge.rb
# Description:  Monkey Patches und Werkzeuge
# Version:  12.01.2015
# Created:  12.01.2015
# Revision:  none
# Language: Ruby 2.1.5
# Author:  Sascha K. Biermanns (Silberbogen), skkd.h4k1n9 AT yahoo PUNKT de
# License:  ISC
# Copyright (C)  2015, Sascha K. Biermanns
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


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
  def addiere_ziffern
    to_s.split(//).inject(0) { | z, x| z + x.to_i }
  end

  def collatz
    if self == 1
      return 1
    elsif even?
      return 1 + (self/2).to_i.collatz
    else
      return 1 + (3 * self + 1).to_i.collatz
    end
  end

  def collatz_sequenz
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
  
  def echte_teiler
    teiler(false)
  end
  
  def faktorisiere
    f = 1
    for i in 1..self
      f *= i
    end
    f
  end
  
  def ist_abundante_zahl?
    if echte_teiler.inject(:+) > self
      return true
    else
      return false
    end
  end

  def ist_befreundete_zahl?
    bz = echte_teiler.inject(:+)
    self == bz.echte_teiler.inject(:+)
  end

  def ist_defiziente_zahl?
    echte_teiler.inject(:+) < self
  end

  def ist_dreieckszahl?
    wert = Math.sqrt(1 + (8 * self))
    wert == wert.to_i
  end

  def ist_fünfeckszahl?
    wert = (1 + Math.sqrt(24 * self + 1)) / 6
    wert == wert.to_i
  end

  def ist_lychrel_zahl?(suchtiefe=50)
    if self == self.reverse
      return false
    elsif suchtiefe == 0
      return true
    else
      (self + self.reverse).ist_lychrel_zahl?(suchtiefe - 1)
    end
  end

  def ist_pandigital?
    if self < 0
      return false
    end
    s = self.to_s
    sl = s.length
    set = s.chars.to_set
    set.count == sl && set == ("0"...sl.to_s).to_set || set == ("1"..sl.to_s).to_set 
  end

  def reverse
    to_s.reverse.to_i
  end
 
  def ist_links_trunkierbar?
    return false unless Prime.prime?(self)
    if self > 10
      to_s[1..-1].to_i.ist_links_trunkierbar?
    else
      return true
    end
  end
 
  def ist_rechts_trunkierbar?
    return false unless Prime.prime?(self)
    if self > 10
      (self/10).ist_rechts_trunkierbar?
    else
      return true
    end
  end
 
  def ist_trunkierbare_primzahl?
    return ist_links_trunkierbar? && ist_rechts_trunkierbar?
  end

  def ist_vollkommene_zahl?
    self == echte_teiler.inject(:+)
  end

  def ist_zirkuläre_primzahl?
    def rotiere(n)
      ziffern = n.to_s.chars
      ziffern.map do
        ziffern.rotate!.join.to_i
      end
    end
    rotiere(self).all? { |i| Prime.prime?(i) }
  end

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

  alias :rückwärts :reverse
end


##############################
# Monkey Patches für Numeric #
##############################


class Numeric
  def ist_palindrom?
    to_s.ist_palindrom?
  end

  def ist_permutation?(x)
    to_s.ist_permutation?(x.to_s)
  end

  def ist_quadratzahl?
    self == Math.sqrt(self)**2
  end
end


#############################
# Monkey Patches für String #
#############################


class String
  def ist_palindrom?
    self == reverse
  end

  def ist_permutation?(x)
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
  a, b = 1, 1
  while a <= n
    yield a
    a, b = b, a+b
  end
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



