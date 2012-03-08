# ABSTRACT: Represents a user in the Mixcloud API
package WWW::Mixcloud::User;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Picture;

=head1 ATTRIBUTES

=head2 url

=cut

has url => (
    is       => 'ro',
    required => 1,
);

=head2 username

=cut

has username => (
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

=head2 pictures

ArrayRef of L<WWW::Mixcloud::Picture> objects.

=cut

has pictures => (
    isa      => 'ArrayRef[WWW::Mixcloud::Picture]',
    is       => 'ro',
    required => 1,
    default  => sub { [] },
);

__PACKAGE__->meta->make_immutable;

=head1 METHODS

=head2 new_from_data

    my $user = WWW::Mixcloud::User->new_from_data( $data )

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
