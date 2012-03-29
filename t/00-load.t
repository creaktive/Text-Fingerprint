use strict;
use utf8;
use warnings qw(all);

use Test::More tests => 1;

BEGIN {
    use_ok(q(Text::Fingerprint));
};

diag(qq(Testing Text::Fingerprint v$Text::Fingerprint::VERSION, Perl $], $^X));
