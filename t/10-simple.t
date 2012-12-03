use strict;
use utf8;
use warnings qw(all);

use Test::More;

use_ok(q(Text::Fingerprint), qw(:all));

my $str = q(
    À noite, vovô Kowalsky vê o ímã cair no pé do pingüim
    queixoso e vovó põe açúcar no chá de tâmaras do jabuti feliz.
);

is(
    fingerprint($str),

    q(a acucar cair cha de do e feliz ima jabuti kowalsky) .
    q( no noite o pe pinguim poe queixoso tamaras ve vovo),

    q(fingerprint)
);

is(
    fingerprint_ngram($str),

    q(abacadaialamanarasbucachcudedoeaedeieleoetevfeg) .
    q(uhaifiminiritixizjakokylilsmamqngnoocoeoiojokop) .
    q(osovowpepipoqurarnsdsksotatetiucueuiutvevowaxoyv),

    q(fingerprint_ngram)
);

is(
    fingerprint_ngram($str, 1),

    q(abcdefghijklmnopqrstuvwxyz),

    q(fingerprint_ngram(..., 1))
);

done_testing(4);
