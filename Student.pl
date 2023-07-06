# Define the Student class
package Student;
 
# Inherit from the Person class
require "/Users/elyes/Desktop/Coursera/Perl/src/User.pl";
use base 'User';

# Define the constructor
sub new{
    my $class = shift;
    my $self = $class->SUPER::new(@_);
    $self->{major} = shift;
    return $self;
}

$student = Student->new('elues', 'mahjoibi', '124', 1, 19);
