use strict;
use warnings;

package DjangoModelGenerator::DjangoModelWriter;

sub new {
    my $class = shift;
    my $self;
    $self->{fileparse} = shift;
    $self->{pyfile} = shift;
    bless $self, $class;
    return $self;
}

sub pyfilewriter {
    my $self = $_[0];
    my $file = $self->_read();
    return $file;
}

sub _read {
    my $self = $_[0];
    open(my $file, '>', $self->{pyfile}) or die "Could not open file: $!";
    return $file
}


1;
