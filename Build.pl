use strict;
use warnings;
use Module::Build;

use v5.38.0;

my $builder = Module::Build->new(
    module_name         => 'EasyModel/Build',
    license             => 'perl',
    dist_abstract       => 'Generate django models with a simple text editor.',
    dist_author         => 'Elyes Mahjoubi <elyesmahjoubi@gmail.com>'
);

$builder->create_build_script();