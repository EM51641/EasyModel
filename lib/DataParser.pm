use strict;
use warnings;

package DjangoModelGenerator::DataParser;


sub new {
    my $class = shift;
    my $self;
    $self->{line} = shift;
    bless $self, $class;
    return $self;
}

sub parse {

    my $self = $_[0];
    my @fields = $self->_split();
    my $line;

    if($fields[0] eq 'M'){
        $line = $self->_model_parser(@fields);
    }
    elsif($fields[0] eq 'F'){
        $line = $self->_field_parser(@fields);
    }
    else{
        die("Only 'F' and 'M' characters are allowed.");
    }
    return $line;
}

sub _split {
    my $self = $_[0];
    my @fields = split(/\s+/, $self->{line});
    return @fields;
}

sub _model_parser {
    my ($self, @classname)  = @_;
    return "class $classname[1](models):\n";
}

sub _field_parser {
    my (
        $self,
        $field_code,
        $field_name,
        $field_type,
        @other_fields
    ) = @_;

    my $non_essentials = $self->_set_non_essential_fields(@other_fields);
    my $type_field = $self->_set_field_type($field_type);

    if(substr($type_field, -1) ne "(" && $non_essentials){
        $non_essentials = ", ".$non_essentials;
    }
    print "   $field_name=models.$type_field$non_essentials)\n";
    return "   $field_name=models.$type_field$non_essentials)\n";
}

sub _set_non_essential_fields {
    my ($self, @fields) = @_;
    my $string = ""; 

    foreach my $field(@fields){
        my $temp_string = "$field=True, ";
        $string = $string.$temp_string;
    };

    return substr($string, 0, -2);
}

sub _set_field_type {
    my ($self, $type) = @_;
    my $string;

    if ($type =~ m/varchar.?+/) {
        my $max_char = $self->_check_max_char($type);
        my $option = "";
        if($max_char){
            $option = "max_length=$max_char";
        }
        $string = "CharField($option";
        return $string;
    }
    elsif($type =~ m/bigint/){
        return "BigIntegerField(";
    }
    elsif($type =~ m/int/){
        return "IntegerField(";
    }
    elsif($type =~ m/datetime/){
        return "DateTimeField(";
    }
    elsif($type =~ m/date/){
        return "DateField(";
    }
    elsif($type =~ m/fkey.?+/){
        my @elems = $self->_check_fkey($type);
        $string = "ForeignKey($elems[0]";
        if(scalar(@elems) eq 2){
            $string = $string.", $elems[1]";
        }
        return $string;
    }
    else{
        die "unknown key $type";
    }
}

sub _check_max_char {
    my ($self, $string) = @_;
    my ($max_char) = $string =~ m/\([0-9]+\)/g;

    if ($max_char){
        my $max_string = substr($max_char, 1, -1);
        return $max_string;
    }else{
        return undef;
    }
}

sub _check_fkey {
    my ($self, $fkey_options) = @_;
    my ($options) = $fkey_options =~ m/(\([a-zA-Z0-9,]+\))/g;

    if ($options){
        my $string_to_parse = substr($options, 1, -1);
        my @elems = split /\,/, $string_to_parse;
        my $table_name = $elems[0];

        if(scalar(@elems) eq 2){
            my $delete_option = $self->_check_cascade($elems[1]);
            return "$table_name, $delete_option";
        }
        elsif(scalar(@elems) > 2){
            die("Couldn't determin $elems[2]");
        }
        return $table_name;
    }
}

sub _check_cascade {
    my $self = shift;
    my $delete_option = shift;
    my $string;

    if ($delete_option =~ m/CASCADE/) {
        $string = "models.CASCADE";
    }
    elsif($delete_option =~ m/PROTECT/){
        $string = "models.PROTECT";
    }
    elsif($delete_option =~ m/NULL/){
        $string = "models.SET_NULL";
    }
    else{
        die "'Only 'CASCADE', 'PROTECT' are 'NULL' are available"
    }
    return "on_delete=$string"
}


1;
