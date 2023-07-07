use Test::Simple tests => 1;
use lib qw(lib);
use DjangoModelWriter;
use Test::MockObject;
use Test::MockFile;

my $py_file = Test::MockFile->file("module.py");
my $parser = Test::MockObject->new();

my $model_generator = DjangoModelGenerator::DjangoModelWriter->new(
    $parser, $py_file);

ok( $model_generator->pyfilewriter() );
