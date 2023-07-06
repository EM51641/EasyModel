package User;

use Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(new);

sub new{
    $class = shift;
    $self = {
        username => shift,
        password => shift,
        id => shift,
        _ny => undef,
    };
    bless $self, $class;
    return $self;
};

sub setUsername{
    ($self, $val) = @_;
    $self->{username} = $val if defined($val);
    return;
}

my $user = new('User', 'elyes', '12345', 1);
print $user->{username};
