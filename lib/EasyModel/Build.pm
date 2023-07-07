use strict;
use warnings;

# This module only inherits from the others
# which are doing the work.
package EasyModel::Build;

use v5.38.0
use EasyModel::Build::DataParser
use EasyModel::Build::FileParser
use EasyModel::Build::DjangoModelWriter

our $VERSION = '1.0';
$VERSION = eval $VERSION;


use version;


1;