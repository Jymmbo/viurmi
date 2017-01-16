#!/usr/local/bin/perl
use strict;
use warnings;

use Path::Class;

#-------------------------------------

print("leyendo wiki_02.txt\n");

my $file1='/home/vjramirez/Documentos/corpus/wiki_02.txt';
open(INFO, $file1) or die("Could not open  file.");

my $contenido = "";
my $conteo = 0;
print("iterando wiki_02.txt\n");

foreach my $line (<INFO>){    
    if ($line eq "@@@@@@@@@@\n"){
      my $filex = "/home/vjramirez/Documentos/corpus/subwiki.txt";
      unless(open FILE, '>'.$filex){
        die "\nImposible crear $filex\n";
      }
      print FILE $contenido;
      close FILE;
      $contenido = "";
      print $conteo . "END\n***** INICIANDO No. " . $conteo  . "*****\nGENERANDO ENTIDADES NOMBRADAS\n";
      if ($conteo > 133715){
        system('cd /home/vjramirez/Documentos/stanford-ner-2015-12-09 && time java -mx10G -cp "*:lib/*" edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier classifiers/english.all.3class.distsim.crf.ser.gz -outputFormat tabbedEntities -textFile /home/vjramirez/Documentos/corpus/subwiki.txt > /home/vjramirez/Documentos/corpus/articulos/sample' . $conteo  . "X.tsv");
        print "BORRANDO TEXTO INNECESARIO\n";
        system("cut -d'	' -f3 --complement /home/vjramirez/Documentos/corpus/articulos/sample" . $conteo . "X.tsv > /home/vjramirez/Documentos/corpus/articulos/sample". $conteo . ".tsv");
        print "BORRANDO LINEAS EN BLANCO\n";
        system("sed -i '/^\\t*\$/d' /home/vjramirez/Documentos/corpus/articulos/sample" . $conteo . ".tsv ");
        print "ELIMINANDO ARCHIVO BACKUP\n";
        system("rm /home/vjramirez/Documentos/corpus/articulos/sample" . $conteo . "X.tsv");
      }
      print "***** FINALIZADO No. " . $conteo . "*****\n" ;
      $conteo = $conteo + 1;
      #last;
    }
    else{ 
    	$contenido = $contenido . $line;
	print ".";  
    }
    #print "-" . $line . "-\n";
}
close(INFO);
print "terminado TOTAL!!\n";
