package WWW::Mixcloud::Track;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Artist;

has url => (
    is       => 'ro',
    required => 1,
);


has artist => (
    isa      => 'WWW::Mixcloud::Artist',
    is       => 'ro',
    required => 1,
);


has name => (
    is       => 'ro',
    required => 1,
);


has key => (
    is       => 'ro',
    required => 1,
);

has slug => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

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
