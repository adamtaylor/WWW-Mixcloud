# ABSTRACT: Represents a track in the Mixcloud API
package WWW::Mixcloud::Track;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Artist;

=head1 ATTRIBUTES

=head2 url

=cut

has url => (
    is       => 'ro',
    required => 1,
);

=head2 artist

An L<WWW::Mixcloud::Artist> object.

=cut

has artist => (
    isa      => 'WWW::Mixcloud::Artist',
    is       => 'ro',
    required => 1,
);

=head2 name

=cut

has name => (
    is       => 'ro',
    required => 1,
);

=head2 key

=cut

has key => (
    is       => 'ro',
    required => 1,
);

=head2 slug

=cut

has slug => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head1 METHODS

=head2 new_from_data

my $track = WWW::Mixcloud::Track->new_from_data( $data )

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    return $class->new({
        url    => $data->{url},
        artist => WWW::Mixcloud::Artist->new_from_data( $data->{artist} ),
        name   => $data->{name},
        key    => $data->{key},
        slug   => $data->{slug},
    });
}

1;
