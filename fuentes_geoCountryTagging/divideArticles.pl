#!/usr/local/bin/perl
use strict;
use warnings;

use Path::Class;

print("Creando wiki_02.txt\n");

my $filex = "wiki_02.txt";

# Use the open() function to create the file.
unless(open FILE, '>'.$filex) {
    # Die with error message 
    # if we can't open it.
    die "\nUnable to create $filex\n";
}

# close the file.
close FILE;

#-------------------------------------

print("leyendo wiki_01\n");

my $file1='wiki_01';
open(INFO, $file1) or die("Could not open  file.");

print("abriendo  wiki_02.txt\n");

my $dir = dir("/home/vjramirez/Documentos/corpus"); # /tmp
my $file = $dir->file("wiki_02.txt"); # /tmp/file.txt
my $file_handle = $file->openw();
my $count = 0; 

print("insertando en  wiki_02.txt\n");

foreach my $line (<INFO>){
    if ($line eq "\n"){
      $count = $count + 1;
    }
    else{ $count = 0;}
    if($count == 3){
      $line = "@@@@@@@@@@\n";
      $count = 0;
    }
    #print "-" . $line . "-\n";
    print $count;
    $file_handle->print( $line );
}

close(INFO);

