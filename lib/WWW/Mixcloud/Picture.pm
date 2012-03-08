# ABSTRACT: Represents a picture in the Mixcloud API
package WWW::Mixcloud::Picture;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

=head1 ATTRIBUTES

=head2 size

=cut

has size => (
    is       => 'ro',
    required => 1,
);

=head2 url

=cut

has url => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head1 METHODS

=head2 new_list_from_data

    my @pictures = WWW::Mixcloud::Pictures->new_list_from_data( $data )

=cut

sub new_list_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    my @pictures;

    while ( my ( $size, $url ) = each %{$data} ) {
        push @pictures, $class->new({
            size => $size,
            url  => $url,
        });
    }

    return \@pictures;
}

1;
