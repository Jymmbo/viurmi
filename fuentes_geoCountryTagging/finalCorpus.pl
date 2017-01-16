#!/usr/local/bin/perl
use strict;
use warnings;

#use Path::Class;

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };


#-------------------------------------
print("Creando el corpus final...\n");

system("cut -d'	' -f2 --complement tmpArticulos/tmpxDataNamedEntities.txt | sort -k 1,1 --field-separator='	' > tmpArticulos/tmpDataNamedEntities.txt");

my $file1='tmpArticulos/tmpDataNamedEntities.txt';
open(INFO1, $file1) or die("Could not open  file.");

my @INFO1 = <INFO1>;

close(INFO1);

my $file2='countries2.txt';
			open(INFO2, $file2) or die("Could not open  file.");

my @INFO2 = <INFO2>;

close(INFO2);

my $namedEntity ="";
my $pais ="";
my $cadena = "";
my $codPais = "";
my $contador = 0;

foreach my $line1 (@INFO1){
	chomp $line1;
	my @columns = split (/\t/, $line1);
	if (length($columns[0]) > 3){
		if ($namedEntity ne $columns[0]){
			if ($cadena ne ""){
				if ($pais ne $columns[1]){
					#$codPais = `grep "$pais" countries2.txt`;
					foreach my $line2 (@INFO2){
						chomp($line2);
						my @vecLine2 = split (/\t/, $line2);
						if ($pais eq $vecLine2[1]) {
  		 				$codPais = trim($vecLine2[0]);
						}
					}
					#chomp $codPais;
					#my @vecPais = split (/\t/, $codPais);
					#$codPais = trim($vecPais[0]);
					$cadena = $cadena . "	" . $codPais . "|" . $contador;		
					$contador = 0;		
					$pais = $columns[1];
				}					
				print($cadena . "\n");
				system("echo '$cadena' >> tmpArticulos/finalCorpus.txt");
			}
			$namedEntity = $columns[0];
			$pais = $columns[1];		
			$cadena = $namedEntity;
		}
		if ($pais ne $columns[1]){
			#$codPais = `grep "$pais" countries2.txt`;
			foreach my $line2 (@INFO2){
				chomp($line2);
				my @vecLine2 = split (/\t/, $line2);
				if ($pais eq $vecLine2[1]) {
   				$codPais = trim($vecLine2[0]);
				}
			}
			#chomp $codPais;
			#my @vecPais = split (/\t/, $codPais);
			#$codPais = trim($vecPais[0]);
			$cadena = $cadena . "	" . $codPais . "|" . $contador;		
			$contador = 0;		
			$pais = $columns[1];
		}
	$contador = $contador + 1;
	}
}

# -------------------------------------------------------

print("Terminado!\n");
