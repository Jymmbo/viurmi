#!/usr/local/bin/perl
use strict;
use warnings;

use Path::Class;

#-------------------------------------
print("Uniendo Articulos...\n");
#-print("cd /home/vjramirez/Documentos/corpus/tmpArticulos && cat articulos/* > JoinedArticles.txt");
#-Se usa xargs para dividir la salida de LS en pedazos de 32 argumentos en 8 procesos ya que si hago el CAT directamente da un error por exceso de argumentos

system("cd articulos && ls | xargs -n 32 -P 8 cat >> ../tmpArticulos/JoinedArticles.txt");
print("Terminado!\nOrdenando y quitando duplicados...\n");
system("cd ../tmpArticulos && sort -u JoinedArticles.txt > UniqueNamedEntities.txt");
print("Terminado!\nFiltrando Nuevamente para que queden unicos...");

my $file1='tmpArticulos/UniqueNamedEntities.txt';
open(INFO, $file1) or die("Could not open  file.");

my $dir = dir("tmpArticulos"); # /tmp
my $file = $dir->file("tableUniqueNamedEntities.txt"); # /tmp/file.txt
my $file_handle = $file->openw();

my $anterior = "XXXXXX";

foreach my $line (<INFO>){
  my @columns = split (/\t/, $line);
  if ($columns[0] eq $anterior) {
    print("Eliminado " . $columns[0] . " ....\n");
  }
  else{ 
    $file_handle->print( $line );
    $anterior = $columns[0];
  }
}

close(INFO);

print("Terminado!\n");