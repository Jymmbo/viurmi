#!/usr/local/bin/perl
use strict;
use warnings;

#use Path::Class;

#-------------------------------------
print("Creando tabla de entidades nombradas con paises...\n");

my $file1='wiki/wad';
open(INFO, $file1) or die("Could not open  file.");


#my $dir = dir("tmpArticulos"); # /tmp
#my $file = $dir->file("DataNamedEntities.txt"); # /tmp/file.txt
#my $file_handle = $file->openw();


my $file2='tmpArticulos/tableUniqueNamedEntities.txt';
open(INFO2, $file2) or die("Could not open  file.");

my @INFO2 = <INFO2>;

close(INFO2);

my $file3='countries.txt';
			open(INFO3, $file3) or die("Could not open  file.");

my @INFO3 = <INFO3>;

close(INFO3);

my $contador=0;

foreach my $line1 (<INFO>){
	print(".");
	$contador++;
	system("echo '$contador' >> tmpArticulos/DcontadorDataNE.txt");
	if ($contador > 9722) {
		foreach my $line2 (@INFO2){
			chomp $line2;
			my @columns = split (/\t/, $line2);
			if (index($line1, $columns[0] . " ") != -1) {

				foreach my $line3 (@INFO3){
					chomp $line3;
					if (index($line1, $line3 . " ") != -1) {
						print("*");
						system("echo '$line2	$line3' >> tmpArticulos/DDataNamedEntities.txt");

						#$file_handle->print( $line2 . "\t". $line3 . "\n" );
					}
				}
				
			}
		}
	}  
	
}

close(INFO);


print("Terminado!\n");