use strict;
use warnings;

package EasyModel::Build::FileParser;

sub new {
    my $class = shift;
    my $self;
    $self->{file} = shift;
    bless $self, $class;
    return $self;
}

sub read {
    my $self = $_[0];
    open my $info, $self->{file} or die "Could not open file: $!";
    return $info;
}


1;