#!/usr/bin/env nextflow
echo true

cheers = Channel.from 'Bonjour', 'Ciao', 'Hello', 'Hola', 'Oi', 'czest', 'Bonjour', 'Ciao', 'Hello', 'Hola', 'Oi', 'czest'

process sayHello {
  container "progrium/stress"
  input: 
    val x from cheers

  output:
    file 'temp' into cheers2

  script:
    """
    echo '$x world!' > temp
    stress -c 5 -t 10
    """



}
process saymerge{

  input:
    file results from cheers2

  output:
    file 'output.txt' into cheers3
  script:
     """
     cat ${results} >> output.txt
     """
}

//process bar {
//  publishDir '/mnt/efs/resultsfinal/'
// input:
//  file 'out*' from cheers3.collect()
//  output:
//    file 'final.out' into cheers4
//  """
//  cat out* >> "final.out" 
//  """
//}

