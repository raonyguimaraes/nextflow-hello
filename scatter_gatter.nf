#!/usr/bin/env nextflow
echo true

chrs = Channel.from 1..22

process per_chr {
  //container "progrium/stress"
  input: 
    val x from chrs

  output:
  file 'temp*' into chrs2

  script:
    """
    echo 'plink chr $x'
    echo 'plink chr $x' > temp$x
    #stress -c 5 -t 10
    """
}
process merge_all{

  publishDir 'resultsfinal/'
  input:
    file results from chrs2.collect()

  output:
  file 'output.txt' into chrs3
  
  script:
    """
    echo 'merge all'
    cat ${results} >> output.txt
    """
}
