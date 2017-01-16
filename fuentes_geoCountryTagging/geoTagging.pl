#!/usr/local/bin/perl
use strict;
use warnings;

#use Path::Class;

sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };
sub createLog {
	system("mkdir -p log");
}

# (1) quit unless we have the correct number of command-line args
my $num_args = $#ARGV + 1;
if ($num_args < 2) {
    print "\nUsage: perl geoTagging.pl -f filename\n";
    print "	perl geoTagging.pl -t 'String'\n";
    exit;
}

# (2) we got two command line args, so assume they are the
# first name and last name
my $flag=$ARGV[0];
my $file=$ARGV[1];
my $enMaxLength = 6;
if (defined $ARGV[2]){
	if ($ARGV[2] =~ /^\d+?$/) {
    	$enMaxLength = $ARGV[2];
	}
}
my @contenido;
my $time = time();


my $numLinea=0;

if ($flag eq '-t'){
	createLog();

	system("echo '$file' >> log/t${time}.txt");
	#system("cd stanford-ner-2015-12-09 && bash nerGT.sh ../log/t${time}.txt ../log/EN${time}.tsv");
	@contenido = `cat log/t${time}.txt`;
}
elsif ($flag eq '-f'){
	createLog();
	system("cp $file log/t${time}.txt");
	@contenido = `cat log/t${time}.txt`;

}
else {
	print "\nFlag '$flag' not recognized!\nUsage:\nperl geoTagging.pl -f filename\n";
    print "perl geoTagging.pl -t 'String'\n";
    exit;
}

my $file1='tmpArticulos/finalCorpus.txt';
open(INFO1, $file1) or die("Could not open  file.");

my @INFO1 = <INFO1>;

#my $file2='countries2.txt';
#			open(INFO2, $file2) or die("Could not open  file.");
#
#my @INFO2 = <INFO2>;

#close(INFO2);


foreach my $linea (@contenido){ 
	$numLinea++;
	system("touch log/P${time}_${numLinea}.txt");
	chomp $linea;
	my $cantidadPal = $enMaxLength;
	my $line = $linea;
	$line =~ s/[,.:;"'?!]/ /g;
	$line =~ s/[ ]{2}/ /g;
	my @vecLinea = split (/ /, $line);
	my $tamano = scalar(@vecLinea);
	for (my $i=$cantidadPal; $i > 0; $i--) {
		my $inicio=0;
		for (my $y=$cantidadPal-1; $y < $tamano; $y++) {
			my $newstring = join(' ', @vecLinea[$inicio..$y]);
			
			#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

			my @listEN;

			foreach my $line1 (@INFO1){
				chomp $line1;
				my @columns = split (/\t/, $line1);
				if ($newstring eq $columns[0]){
					#print($line1 . "\n");
					system("echo '$line1' >> log/NE${time}_${numLinea}.txt");
					push(@listEN, "$line1");
				} 
			}

			foreach my $line2 (@listEN){
				my @columns2 = split (/\t/, $line2);
				my $mayorValor =0;
				my $codePais = "";
				for (my $k=1; $k < scalar(@columns2); $k++){
					#print($columns2[$k] . "\n");
					my @columns3 = split (/\|/, $columns2[$k]);
					#print($columns3[0] . "\n");
					if ($columns3[1] > $mayorValor){
						$mayorValor = $columns3[1];
						$codePais = $columns3[0];
					}
				}
				system("echo '$codePais' >> log/P${time}_${numLinea}.txt");
			}


			#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

			$inicio++;
    	}
    	$cantidadPal--;
    }

    my @paisOrden = `cat log/P${time}_${numLinea}.txt | sort | uniq -c  | sort -nr `;
    my $max5=5;
    if (scalar(@paisOrden)<5){
    	$max5=scalar(@paisOrden);
    }

    my $cadenaFinal ="";
    for(my $j=0; $j<$max5; $j++){
    	#print($paisOrden[$j] . "\n");
    	my @columns4 = split (/ /, $paisOrden[$j]);
    	my $lineaEnListado = $columns4[scalar(@columns4)-1];
    	my $pesoEnListado = $columns4[scalar(@columns4)-2];
    	chomp $lineaEnListado;
    	#print($lineaEnListado . "\n");
    	my $nombrePais = `sed -n '${lineaEnListado}p' countries2.txt`;
    	chomp($nombrePais);
    	my @columns5 = split (/\t/, $nombrePais);
    	#print($nombrePais);
    	$cadenaFinal = $cadenaFinal . $columns5[1] . "@" . $pesoEnListado . '^';
    }

    chop($cadenaFinal);

    print($linea . '|' . $cadenaFinal . "\n");
    if ($flag eq '-f'){
    	$linea =~ s/["]/'/g;
    	system("echo \"$linea|$cadenaFinal\" >> ${file}result.txt");
    }
    

}


#print($contenido[0]);

print("Process Complete!\n");
