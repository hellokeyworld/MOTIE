#!/opt/Yonsei/Python/2.7.15/bin/python

try:
        import sys, os,re, time,copy,commands,argparse
        import numpy as np
        from os.path import isfile, join, abspath
	from subprocess import Popen,PIPE
except ImportError:
        sys.exit("## ERROR: Required python package or packages are not installed.\n \
         Check and install the package or packages with 'pip install'.\
         - Required python packages : numpy, multiprocessing")


def run_p(cmm):
        print cmm
        try:
                prc= Popen(cmm, stdout=PIPE, shell=True, stderr=PIPE)
                stdoutput, stderr = prc.communicate()
                if prc.returncode != 0:
                        print stderr
                        raise
                        exit()
        except KeyboardInterrupt:
                for p in multiprocessing.active_children():
                        p.terminate()
                exit()


files= sys.argv[1]  ##'/data/project/MOTIE/Tool/calcpkg/test/config'
hla_info = sys.argv[2]  ## Y/N or YES/NO


print('config file check : ', files)
print('hla check : ', hla_info)


def get_file_list(fullpath_config, hla_info):
	Ins = []
	with open(fullpath_config,'r') as inputs:
		for line in inputs :
			if line.startswith('#') : continue
			line = line.replace("'","").replace('"','').replace(' ','')
			line = line.rstrip()
			line = line.split('#')[0]
			if len(line) == 0 : continue
			else :
				tmps=line.split('=')[1]
				Ins.append(tmps)
	paths = str(fullpath_config).split('MOTIE/calcpkg')[0]
	if str(hla_info).upper() == 'YES' or str(hla_info).upper() == 'Y' : 
		cmm = "bash "+paths+"/MOTIE/calcpkg/lib/neopepsee/pipe_neopepsee.sh {0} {1} {2} {3} {4} {5} {6} {7}".format(Ins[0],Ins[1],Ins[2],Ins[3],Ins[4],Ins[5],Ins[6], Ins[7])
	elif str(hla_info).upper() =='NO' or str(hla_info).upper() == 'N' :
		cmm = "bash "+paths+"/MOTIE/calcpkg/lib/neopepsee/pipe_optitype_neopepsee.sh {0} {1} {2} {3} {4} {5} {6} {7}".format(Ins[0],Ins[1],Ins[2],Ins[3],Ins[4],Ins[5],Ins[6],Ins[7])
	print(cmm)
	os.system(cmm)



get_file_list(files, hla_info)



