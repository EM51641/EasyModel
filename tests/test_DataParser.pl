use Test::Simple tests => 8;
use lib qw(lib);
use DjangoModelGenerator::DataParser;
use Test::MockObject;
use Test::MockFile;

$test_first = DjangoModelGenerator::DataParser->new('M User');
ok( $test_first->parse() eq "class User(models):\n");

$test_second = DjangoModelGenerator::DataParser->new('F name varchar(50)');
ok( $test_second->parse() eq "   name=models.CharField(max_length=50)\n");

$test_third = DjangoModelGenerator::DataParser->new('F score int null blank unique');
ok( $test_third->parse() eq "   score=models.IntegerField(null=True, blank=True, unique=True)\n");

$test_fourth = DjangoModelGenerator::DataParser->new('F id bigint unique');
ok( $test_fourth->parse() eq "   id=models.BigIntegerField(unique=True)\n");

$test_fifth = DjangoModelGenerator::DataParser->new('F date datetime blank');
ok( $test_fifth->parse() eq "   date=models.DateTimeField(blank=True)\n");

$test_sixth = DjangoModelGenerator::DataParser->new('F created date null');
ok( $test_sixth->parse() eq "   created=models.DateField(null=True)\n");

$test_seven = DjangoModelGenerator::DataParser->new('F user_id fkey(User,CASCADE) null');
ok( $test_seven->parse() eq "   user_id=models.ForeignKey(User, on_delete=models.CASCADE, null=True)\n");

$test_eight = DjangoModelGenerator::DataParser->new('F surname varchar');
ok( $test_eight->parse() eq "   surname=models.CharField()\n");
