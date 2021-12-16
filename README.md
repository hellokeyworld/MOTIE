
# MOTIE
> Thank you for your interest in our work. In this github you will find :

This tool can detect more accurate neoantigen based on Neopepsee with user-friendly pipelines.

Pipeline incorporating HLA typing analysis using Optitype and neoantigen detection using Neopepsee.

Optitype was used to obtain more accurate patient HLA type information than the HLA typing tool used in the conventional neoantigen detection pipeline.



![](../header.png)

## Required tools

[Neopepsee 3.0.1](https://sourceforge.net/projects/neopepsee/files/neopepsee-3.0.1.tar.gz/download)

[Optitype](https://github.com/FRED-2/OptiType/)

[RazerS 3.4](http://www.seqan.de/projects/razers/)

[SAMtools 1.2](http://www.htslib.org/)

[HDF5 1.8.15](https://www.hdfgroup.org/HDF5/)

[CPLEX 12.5](http://www-01.ibm.com/software/commerce/optimization/cplex-optimizer/)
   or other Pyomo-supported ILP solver ([GLPK](https://www.gnu.org/software/glpk/), 
   [CBC](https://projects.coin-or.org/Cbc), ...)

[Python 2.7](https://www.python.org/)
  - Numpy
  - Pyomo
  - PyTables
  - Pandas
  - Pysam
  - Matplotlib
  - Future

   
## Installation 

Clone the repository

```sh
git clone https://github.com/hellokeyworld/MOTIE
```

Download the compressed file

```sh
unzip MOTIE-main.zip
```

## Usage

스크린 샷과 코드 예제를 통해 사용 방법을 자세히 설명합니다.
The tools above should be installed in server and the PATH set in the files named "config".


Below is an example for data with HLA info:

```sh
python MOTIE.py [pullpath_config] [YES or Y]
```


Below is an example for data without HLA info:

```sh
python MOTIE.py [pullpath_config] [NO or N]
```


## TEST examples

Below is an example for TEST data with HLA info:

```sh
python TEST.py config YES
```

Below is an example for TEST data without HLA info:

```sh
python TEST.py config NO
```



