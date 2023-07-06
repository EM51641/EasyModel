my $file = 'data.txt';
my $filename = 'module.py';

open(my $pyfile, '>', $filename) or die "Could not open file '$filename' $!";  
print $pyfile "from django.db import models\n";

open my $info, $file or die "Could not open $file: $!";

while( my $line = <$info>)  {   
    my @fields = split /\s+/, $line;
    if($fields[0] eq 'M'){
        print $pyfile "class $fields[1](models):\n";}
    elsif($fields[0] eq 'F'){
        print $pyfile " " x 4, "$fields[1]=models.charfield()\n";
        }
    }

close $pyfile;
close $info;
# print "done\n";

$string = 'varchar(50)';
if ($string =~ m/\([0-9]+\)/g) {
    print $string;
    my $max_string = substr($1, 1, -1);
    print "$max_string done\n";
    }

$string = 'varchar(LOL)';
print substr($string, -1);