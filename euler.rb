#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Filename:  euler.rb
# Description:  Probleme aus dem Euler-Projekt
# Version:  13.01.2015
# Created:  27.12.2014
# Revision:  none
# Language: Ruby 2.1.5
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
require 'werkzeuge'


###########################
# Die Eulerschen Probleme #
###########################


def problem_1
  (1...1000).select{ |i| i % 3 == 0 || i % 5 == 0}.inject(:+)
end



def problem_2
  summe = 0
  fibonacci_generator do |i|
    if i < 4_000_000
      summe += i if i.even?
    else
      return summe
    end
  end
end


def problem_3(zahl = 600851475143)
  # prime_division zerlegt eine Zahl in ihre Primfaktoren
  # diese werden als verschachtelte Liste zurückgegeben:
  # 600851475143.prime_division => [[71, 1], [839, 1], [1471, 1], [6857, 1]]
  zahl.prime_division.max.first
end


def problem_4
  max = 0
  999.downto(100) do |i|
    i.downto(100) do |j|
      zahl = i * j
      max = zahl if zahl.ist_palindrom? && zahl > max
    end
  end
  max
end


def problem_5
  zahl = 1
  (2..20).each { |i| zahl = zahl.lcm(i) }
  zahl
end


def problem_6
  summenquadrat, quadratsumme = 0, 0
  (1..100).each do |i| 
    summenquadrat += i
    quadratsumme += i**2
  end
  (summenquadrat ** 2) - quadratsumme
end


def problem_7
  Prime.first(10001).last
end


def problem_8(stellen = 13,
            zahl = '7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450')
  lösung = 0
  produkt = 1
  for i in 0..zahl.length - stellen do
    produkt = 1
    for j in i...i + stellen do
      produkt *= zahl[j].to_i
    end
    lösung = produkt if produkt > lösung
  end
  lösung
end


def problem_9(n = 1000)
  for a in 1..n/2 do
    for b in a..n/2 do
      c = n - a - b
      return a*b*c if a**2 + b**2 == c**2
    end
  end
end


def problem_10
  Prime.each(2_000_000).inject(:+)
end

def problem_11(stellen=4)
  z = [[ 8, 2,22,97,38,15, 0,40, 0,75, 4, 5, 7,78,52,12,50,77,91, 8,],
       [49,49,99,40,17,81,18,57,60,87,17,40,98,43,69,48, 4,56,62, 0,],
       [81,49,31,73,55,79,14,29,93,71,40,67,53,88,30, 3,49,13,36,65,],
       [52,70,95,23, 4,60,11,42,69,24,68,56, 1,32,56,71,37, 2,36,91,],
       [22,31,16,71,51,67,63,89,41,92,36,54,22,40,40,28,66,33,13,80,],
       [24,47,32,60,99, 3,45, 2,44,75,33,53,78,36,84,20,35,17,12,50,],
       [32,98,81,28,64,23,67,10,26,38,40,67,59,54,70,66,18,38,64,70,],
       [67,26,20,68, 2,62,12,20,95,63,94,39,63, 8,40,91,66,49,94,21,],
       [24,55,58, 5,66,73,99,26,97,17,78,78,96,83,14,88,34,89,63,72,],
       [21,36,23, 9,75, 0,76,44,20,45,35,14, 0,61,33,97,34,31,33,95,],
       [78,17,53,28,22,75,31,67,15,94, 3,80, 4,62,16,14, 9,53,56,92,],
       [16,39, 5,42,96,35,31,47,55,58,88,24, 0,17,54,24,36,29,85,57,],
       [86,56, 0,48,35,71,89, 7, 5,44,44,37,44,60,21,58,51,54,17,58,],
       [19,80,81,68, 5,94,47,69,28,73,92,13,86,52,17,77, 4,89,55,40,],
       [ 4,52, 8,83,97,35,99,16, 7,97,57,32,16,26,26,79,33,27,98,66,],
       [88,36,68,87,57,62,20,72, 3,46,33,67,46,55,12,32,63,93,53,69,],
       [ 4,42,16,73,38,25,39,11,24,94,72,18, 8,46,29,32,40,62,76,36,],
       [20,69,36,41,72,30,23,88,34,62,99,69,82,67,59,85,74, 4,36,16,],
       [20,73,35,29,78,31,90, 1,74,31,49,71,48,86,81,16,23,57, 5,54,],
       [ 1,70,54,71,83,51,54,69,16,92,33,48,61,43,52, 1,89,19,67,48,]]
  länge = z.length
  max = 0
=begin
  for i from 0...länge - stellen do
    for j from 0 ..länge do
      kandidat = z[i][j...j + stellen].inject(:*)
      max = kandidat if kandidat > max
      kandidat = z[j..j + stellen][i]
      max = kandidat if kandidat > max
    end
  end
=end
end  


def problem_12
  i = 1
  while dreieckszahl(i).teiler.count <= 500
    i += 1
  end
  dreieckszahl(i)
end


def problem_14
  max = 0
  x = 0
  (1...1_000_000).each do |i| 
    c = i.collatz
    if c > max
      max = c
      x = i
    end
  end
  x
end


def problem_15
  (40.faktorisiere / 20.faktorisiere / 20.faktorisiere).to_i
end


def problem_16
  (2**1000).addiere_ziffern
end

def problem_20
  (1..100).reduce(:*).addiere_ziffern
end

def problem_25
  i = 0
  fibonacci_generator do |f|
    return i if f.to_s.length == 1_000
    i += 1
  end
end
