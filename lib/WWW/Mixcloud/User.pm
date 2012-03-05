package WWW::Mixcloud::User;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Picture;

has url => (
    is       => 'ro',
    required => 1,
);

has username => (
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

has pictures => (
    isa      => 'ArrayRef[WWW::Mixcloud::Picture]',
    is       => 'ro',
    required => 1,
    default  => sub { [] },
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    my $pictures = WWW::Mixcloud::Picture->new_list_from_data( $data->{pictures} );

    return $class->new({
        url      => $data->{url},
        username => $data->{username},
        name     => $data->{name},
        key      => $data->{key},
        pictures => $pictures,
    });

}

1;
