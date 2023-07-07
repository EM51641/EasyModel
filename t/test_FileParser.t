use Test::Simple tests => 1;
use lib qw(lib);
use EasyModel::Build::FileParser;
use Test::MockFile;

my $foobar = Test::MockFile->file( "data.txt");
my $file = EasyModel::Build::FileParser->new('data.txt');

ok( $file->read() );
