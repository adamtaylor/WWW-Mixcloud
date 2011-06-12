package WWW::Mixcloud;

use Moose;
use namespace::autoclean;

use URI;
use LWP::UserAgent;
use JSON;
use DateTime::Format::Atom;

use WWW::Mixcloud::Cloudcast;
use WWW::Mixcloud::User;
use WWW::Mixcloud::Picture;

use Data::Dump qw/ pp /;

has api_key => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has api_secret => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has ua => (
    is  => 'ro',
    isa => 'LWP::UserAgent',
    lazy_build => 1,
);

__PACKAGE__->meta->make_immutable;

my $API_BASE = 'http://api.mixcloud.com';

sub _build_ua {
    my $self = shift;

    return LWP::UserAgent->new;
}

=head2 cloudcast

    my $cloudcast = $mixcloud->cloudcast( $url );

=cut

sub cloudcast {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $data = $self->_api_call( $uri->path );

    my $cloudcast = WWW::Mixcloud::Cloudcast->new_from_data( $data );
    warn pp $cloudcast;

    return $cloudcast;
}

sub user {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $data = $self->_api_call( $uri->path );

    my @pictures;

    foreach ( @{$data}->pictures ) {
        push @pictures, WWW::Mixcloud::Picture->new({
            size => $_->{size},
            url  => $_->{url},
        });
    }

    my $user = WWW::Mixcloud::User->new({
        url      => $data->{url},
        username => $data->{username},
        name     => $data->{name},
        key      => $data->{key},
        pictures => \@pictures,
    });

}

sub _api_call {
    my ( $self, $path ) = @_;

    my $res = $self->ua->get( $API_BASE . $path );

    if ( $res->is_success ) { 
        #warn pp $res->content;
    }

    return decode_json $res->content;

}

1;
