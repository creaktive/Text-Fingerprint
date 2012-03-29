package Text::Fingerprint;
# ABSTRACT: ...

=head1 SYNOPSIS

    ...

=head1 DESCRIPTION

...

=cut

use strict;
use utf8;
use warnings qw(all);

# VERSION

=func fingerprint($string)

...

=cut

sub fingerprint {
    # The process that generates the key from a string value is the following (note that the order of these operations is significant):
    # 
    # remove leading and trailing whitespace
    # change all characters to their lowercase representation
    # remove all punctuation and control characters
    # split the string into whitespace-separated tokens
    # sort the tokens and remove duplicates
    # join the tokens back together
    # normalize extended western characters to their ASCII representation (for example "gödel" → "godel")

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

=cut

sub fingerprint_ngram {
    # change all characters to their lowercase representation
    # remove all punctuation, whitespace, and control characters
    # obtain all the string n-grams
    # sort the n-grams and remove duplicates
    # join the sorted n-grams back together
    # normalize extended western characters to their ASCII representation

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

=cut

1;
