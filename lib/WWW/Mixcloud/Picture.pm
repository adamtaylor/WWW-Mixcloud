package WWW::Mixcloud::Picture;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

has size => (
    is       => 'ro',
    required => 1,
);

has url => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    warn 'NOOP';
}

=head2 new_list_from_data

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
