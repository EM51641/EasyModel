use Test::Simple tests => 1;
use lib qw(lib);
use FileParser;
use Test::MockFile;

my $foobar = Test::MockFile->file( "data.txt");
my $file = DjangoModelGenerator::FileParser->new('data.txt');

ok( $file->read() );
