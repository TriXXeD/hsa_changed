
import sys
import re
from datetime import datetime, timedelta

#Data example
#Count: 0
#Time: 1077 us
#        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.00
#        Maximum resident set size (kbytes): 1736
#Count: 0
#Time: 1380 us
#        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.00
#        Maximum resident set size (kbytes): 1744



with open (sys.argv[1], 'r') as res_file:
	file_as_lines = res_file.readlines()

file_as_lines = [x.strip() for x in file_as_lines] 


def data_extract(lines):
	# cnt is always the same for all runs
	try:
		cnt = [int(c) for c in lines[0].split() if c.isdigit()]
	except IndexError:
		print(sys.argv[1], ' gives index error on line first line, presumebly out of memory run file')
		return
	microtime, seconds, mem = 0, 0, 0
	for i in range(0, 9):
		lmicrotime = [int(t) for t in lines[i*4+1].split() if t.isdigit()]
		microtime += lmicrotime[0]
		try:
			rtime = datetime.strptime(lines[i*4+2][37:], "%M:%S.%f")
		except ValueError:
			rtime = datetime.strptime(lines[i*4+2][37:], "%H:%M:%S")
		seconds += rtime.second
		lmem = [int(m) for m in lines[i*4+3].split() if m.isdigit()]
		mem += lmem[0]
	avg_micro = microtime/9
	avg_seconds = seconds/9
	avg_mem = mem/9
	newfile_lines = [
			'count: ' + str(cnt[0]) + '\n',
			'hsa_time: ' + str(avg_micro) + ' \n',
			'slurm_time: ' + str(avg_seconds) + '\n',
			'mem_use: ' + str(avg_mem) + '\n',
			]
	file_as_string = ''.join(newfile_lines)
	out = 'avg/' + sys.argv[1]
	with open(out, 'w+') as out_file:
		out_file.write(file_as_string)



def add_to_csv(lines):
	# cnt is always the same for all runs
	try:
		cnt = [int(c) for c in lines[0].split() if c.isdigit()]
	except IndexError:
		#print(sys.argv[1], ' gives index error on line first line, presumebly out of memory run file')
		#newfile_lines = [
		#		sys.argv[2],
		#		'',
		#		'',
		#		'',
		#		'> 50gb \n',
		#		]
		#file_as_string = ','.join(newfile_lines)
		#out = 'avg/res.csv'
		#with open(out, 'a') as out_file:
		#	out_file.write(file_as_string)
		return
	#microtime, seconds, mem = 0, 0, 0
	microtime, seconds, mem = [], [], []
	for i in range(0, 9):
		lmicrotime = [int(t) for t in lines[i*4+1].split() if t.isdigit()]
		#microtime += lmicrotime[0]
		microtime.append(lmicrotime[0])
		
		try:
			rtime = datetime.strptime(lines[i*4+2][45:], "%M:%S.%f")
		except ValueError:
			rtime = datetime.strptime(lines[i*4+2][45:], "%H:%M:%S")
		#seconds += rtime.second
		seconds.append(rtime.second + rtime.minute*60 + rtime.hour*60*60 + round(rtime.microsecond/1000000, 2))
		lmem = [int(m) for m in lines[i*4+3].split() if m.isdigit()]
		#mem += lmem[0]
		mem.append(lmem[0])

		if len(lines) < 7:
			break
	#avg_micro = round(microtime/9, 2)
	#avg_seconds = round(seconds/9, 2)
	#avg_mem = round(mem/9, 2)
	min_micro = min(microtime)
	min_seconds = min(seconds)
	min_mem = min(mem)
	min_mem = min_mem/1024/1024
	nest_lvl = sys.argv[2][4]
	k = sys.argv[2][-1:]
	header = sys.argv[2][6:-2]
	newfile_lines = [
			nest_lvl,
			header,
			k,
			str(cnt[0]),
			str(min_micro),
			str(min_seconds),
			str(min_mem) + '\n',
			]
	file_as_string = ','.join(newfile_lines)
	out = 'avg/res.csv'
	with open(out, 'a') as out_file:
		out_file.write(file_as_string)



add_to_csv(file_as_lines)

#data_extract(file_as_lines)
