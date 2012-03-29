package Text::Fingerprint;
# ABSTRACT: perform simple text clustering by key collision

=head1 SYNOPSIS

    use feature qw(say);
    use utf8;

    use Text::Fingerprint qw(:all);

    my $str = q(
        À noite, vovô Kowalsky vê o ímã cair no pé do pingüim
        queixoso e vovó põe açúcar no chá de tâmaras do jabuti feliz.
    );

    say fingerprint($str);
    # a acucar cair cha de do e feliz ima jabuti kowalsky
    # no noite o pe pinguim poe queixoso tamaras ve vovo

    say fingerprint_ngram($str);
    # abacadaialamanarasbucachcudedoeaedeieleoetevfeg
    # uhaifiminiritixizjakokylilsmamqngnoocoeoiojokop
    # osovowpepipoqurarnsdsksotatetiucueuiutvevowaxoyv

=head1 DESCRIPTION

Text clustering functions borrowed from the L<Google Refine|http://code.google.com/p/google-refine/>.
Can be useful for finding groups of different values that might be alternative representations of the same thing.
For example, the two strings "New York" and "new york" are very likely to refer to the same concept and just have capitalization differences.
Likewise, "Gödel" and "Godel" probably refer to the same person.

=cut

use strict;
use utf8;
use warnings qw(all);

use base q(Exporter);

our %EXPORT_TAGS    = (all => [qw(fingerprint fingerprint_ngram)]);
our @EXPORT_OK      = (@{$EXPORT_TAGS{all}});
our @EXPORT         = qw();

use Text::Unidecode;

# VERSION

=func fingerprint($string)

The process that generates the key from a C<$string> value is the following (note that the order of these operations is significant):

=for :list
* remove leading and trailing whitespace
* normalize extended western characters to their ASCII representation (for example "gödel" → "godel")
* change all characters to their lowercase representation
* split the string into punctuation, whitespace and control characters-separated tokens
* sort the tokens and remove duplicates
* join the tokens back together

=cut

sub fingerprint {
    my ($string) = @_;

    return join q( ) =>
        sort
        keys {
            map {
                $_ => 1
            } split
                m{[
                    \p{XPerlSpace} |
                    \p{XPosixCntrl} |
                    \p{XPosixPunct}
                ]+}x =>
                    lc unidecode
                    $string =~ s{
                        ^\s+ |
                        \s+$
                    }{}grsx
        };
}

=func fingerprint_ngram($string, $n)

The L<n-gram|http://en.wikipedia.org/wiki/N-gram> fingerprint method is similar to the C<fingerprint> method described above but instead of using whitespace separated tokens, it uses I<n-grams>, where the C<$n> (or the size in chars of the token) can be specified by the user (default: 2).

=for :list
* change all characters to their lowercase representation
* remove all punctuation, whitespace, and control characters
* normalize extended western characters to their ASCII representation
* obtain all the string n-grams
* sort the n-grams and remove duplicates
* join the sorted n-grams back together

=cut

sub fingerprint_ngram {
    my ($string, $n) = @_;
    $n //= 2;

    return join q() =>
        sort
        keys {
            map {
                $_ => 1
            } (
                lc unidecode
                $string =~ s{
                    \p{XPerlSpace} |
                    \p{XPosixCntrl} |
                    \p{XPosixPunct}
                }{}grsx
            ) =~ m{
                (?=
                    (.{$n})
                )
            }gx
        };
}

=head1 SEE ALSO

=for :list
* L<Text::Unidecode>
* L<Methods and theory behind the clustering functionality in Google Refine.|http://code.google.com/p/google-refine/wiki/ClusteringInDepth>

=cut

1;
