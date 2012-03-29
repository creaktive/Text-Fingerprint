use strict;
use utf8;
use warnings qw(all);

use Test::More;

use_ok(q(Text::Fingerprint), qw(:all));

my $str = q(
    À noite, vovô Kowalsky vê o ímã cair no pé do pingüim
    queixoso e vovó põe açúcar no chá de tâmaras do jabuti feliz.
);

ok(
    fingerprint($str)
        eq
    q(a acucar cair cha de do e feliz ima jabuti kowalsky) .
    q( no noite o pe pinguim poe queixoso tamaras ve vovo),

    q(fingerprint)
);

ok(
    fingerprint_ngram($str)
        eq
    q(abacadaialamanarasbucachcudedoeaedeieleoetevfeg) .
    q(uhaifiminiritixizjakokylilsmamqngnoocoeoiojokop) .
    q(osovowpepipoqurarnsdsksotatetiucueuiutvevowaxoyv),

    q(fingerprint_ngram)
);

done_testing(3);
