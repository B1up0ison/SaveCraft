# Minecraft Cross-Platform World Save Script
This simple PowerShell script enables you to transfer your Minecraft worlds efficiently and accurately via external devices (USB/External SSD/NAS/etc).

How to run:
First place the script onto your chosen storage device (USB)
Then, in order to run the script you can either open a terminal where the program is located and type: .\SaveCraft.ps1 
or
double-clicking on the script

Note: some options notably 4 and 5 are still WIP and are just placeholders.

Basic Benchmarks:
Subsequent Writes between two 2.56GB files, Actual (2,750,172,983) to USB (2,750,172,608) total bytes with a 375-byte difference have yielded a total of 88% time improvement on average, saving ~4 minutes and 9 seconds 
compared to the standard "drag and drop" method for save files.

Drag and Drop:
Average Time: 4.66 Minutes
Worst Time: 5:16.00 Minutes
Best Time: 4:34.96 Minutes

Script:
Average Time: 0:34.00 Seconds
Worst Time: 0:37.00 Seconds
Best Time: 0:27.97 Seconds

Ultra Performance Mode (MT) Benchmark:
