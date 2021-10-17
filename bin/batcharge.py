#!/usr/bin/env python
# coding=UTF-8
import math, subprocess, sys

def showBattery(output):
  o_max = [l for l in output.splitlines() if 'MaxCapacity' in l][0]
  o_cur = [l for l in output.splitlines() if 'CurrentCapacity' in l][0]

  b_max = float(o_max.rpartition('=')[-1].strip())
  b_cur = float(o_cur.rpartition('=')[-1].strip())

  charge = b_cur / b_max
  charge_threshold = int(math.ceil(10 * charge))

  # Output
  srtb = u"\u25b8"    # ▸ (small right triangle black)
  srtw = u"\u25b9"    # ▹ (small right triangle white)
  ssq = u'◼'          # ◼ (solid square)
  esq = u'◻'          # ◻ (empty square)

  total_slots, slots = 10, []
  filled = int(math.ceil(charge_threshold * (total_slots / 10.0))) * ssq
  empty = (total_slots - len(filled)) * esq

  out = (filled + empty).encode('utf-8')

  color_green = '%{[32m%}'
  color_yellow = '%{[1;33m%}'
  color_red = '%{[31m%}'
  color_reset = '%{[00m%}'
  color_out = (
      color_green if len(filled) > 6
      else color_yellow if len(filled) > 4
      else color_red
  )

  out = color_out + out + color_reset
  sys.stdout.write(out)

def main():
  try:
    p = subprocess.Popen(["ioreg", "-rc", "AppleSmartBattery"], stdout=subprocess.PIPE)
  except OSError:
    return

  output = p.communicate()[0]
  if len(output):
    showBattery(output)

if __name__ == '__main__' and sys.version_info.major != 3:
  main()
