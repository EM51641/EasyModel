use Test::Simple tests => 1;
use lib qw(lib);
use EasyModel::Build::DjangoModelWriter;
use Test::MockObject;
use Test::MockFile;

my $py_file = Test::MockFile->file("module.py");
my $parser = Test::MockObject->new();

my $model_generator = EasyModel::Build::DjangoModelWriter->new(
    $parser, $py_file);

ok( $model_generator->pyfilewriter() );
