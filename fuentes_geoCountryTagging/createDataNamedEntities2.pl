#!/usr/local/bin/perl
use strict;
use warnings;

#use Path::Class;

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };


#-------------------------------------
print("Creando tabla de entidades nombradas con paises...\n");

#my $dir = dir("tmpArticulos"); # /tmp
#my $file = $dir->file("DataNamedEntities2.txt"); # /tmp/file.txt
#my $file_handle = $file->openw();


my $file2='tmpArticulos/tableUniqueNamedEntities.txt';
open(INFO2, $file2) or die("Could not open  file.");

my @INFO2 = <INFO2>;

close(INFO2);

my $file3='countries2.txt';
			open(INFO3, $file3) or die("Could not open  file.");

my @INFO3 = <INFO3>;

close(INFO3);

my $contador=0;
	foreach my $line2 (@INFO2){
		chomp $line2;
		my @columns = split (/\t/, $line2);
		my $lineaFinal = "$columns[0]	";
		my $flag = 0;
		$contador = $contador + 1;
		if ($contador > 0){
			system("echo '$contador' >> /docencia/cuentas/8/847002/Documents/corpus/contador.txt");
			foreach my $line3 (@INFO3){
				chomp $line3;
				my @columns2 = split (/\t/, $line3);
				my $valor1 = $columns[0];
				my $valor2 = $columns2[1];
				my $valor3 = trim($columns2[0]);
				my $output_string = `grep "${valor1} " wiki_04.txt | grep "${valor2} " | wc -l`;
				chomp $output_string;
				$output_string = trim($output_string);
				if ($output_string > 0) {
					$flag = 1;
					$lineaFinal = $lineaFinal . "${valor3}|${output_string}	";
					print($valor1 . " - " . $valor2 . " - " . trim($valor3) . " - " . $output_string);
				}
				print(".");
					
			}
			if ($flag == 1){
				system("echo '$lineaFinal' >> /docencia/cuentas/8/847002/Documents/corpus/tmpArticulos/DataNamedEntities2.txt");
			}
		}
	}  
	


print("Terminado!\n");