# ABSTRACT: Perl wrapper for the Mixcloud API
=head1 SYNOPSIS

    use WWW::Mixcloud;

    my $mixcloud = WWW::Mixcloud->new({
        api_key    => $api_key,
        api_secret => $api_secret,
    )};

    my $cloudcast = $mixcloud->get_cloudcast(
        'http://api.mixcloud.com/spartacus/party-time/'
    );

    my $user = $mixcloud->get_user(
        'http://www.mixcloud.com/spartacus/'
    );

    my $tag = $mixcloud->get_tag(
        'http://api.mixcloud.com/tag/funk/'
    );

    my $artist = $mixcloud->get_artist(
        'http://api.mixcloud.com/artist/aphex-twin/'
    );

    my $track = $mixcloud->get_track(
        'http://api.mixcloud.com/track/bonobo/ketto/'
    );

    my $category = $mixcloud->get_category(
        'http://api.mixcloud.com/categories/ambient/'
    );

=head1 DESCRIPTION

WWW::Mixcloud is a simple Perl wrapper for the read only portion of the mixcloud
API.

Each method requires a URL and will return an object representing the data
returned from the API. The attributes on the object match the data from the API.

=head1 METHODS

=head2 new

    my $mixcloud = WWW::Mixcloud->new({ api_key => $key, api_secret => $secret });

Creates a new L<WWW::Mixcloud> object. The key and secret arguments are only
required to use non-readonly portions of the API (not currently supported).

=cut

package WWW::Mixcloud;

use Moose;
use namespace::autoclean;

use URI;
use LWP::UserAgent;
use JSON;
use DateTime::Format::Atom;

use WWW::Mixcloud::Cloudcast;
use WWW::Mixcloud::Cloudcast::Tag;
use WWW::Mixcloud::Artist;
use WWW::Mixcloud::Category;
use WWW::Mixcloud::Track;
use WWW::Mixcloud::User;

use Data::Dump qw/ pp /;

has api_key => (
    isa      => 'Str',
    is       => 'ro',
    required => 0,
);

has api_secret => (
    isa      => 'Str',
    is       => 'ro',
    required => 0,
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

=head2 get_cloudcast

    my $cloudcast = $mixcloud->get_cloudcast( $url );

Returns a L<WWW::Mixcloud::Cloudcast> object. C<$url> should be a valid cloudcast
URL.

=cut

sub get_cloudcast {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Cloudcast->new_from_data( $data );
}

=head2 get_user

    my $user = $mixcloud->get_user( $url );

Returns a L<WWW::Mixcloud::User> object. C<$url> should be a valid user URL.

=cut

sub get_user {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::User->new_from_data( $data );
}

=head2 get_tag

    my $tag = $mixcloud->get_tag( $url );

Returns a L<WWW::Mixcloud::Cloudcast::Tag> object. C<$url> should be a valid tag
URL.

=cut

sub get_tag {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Cloudcast::Tag->new_from_data( $data );
}

=head2 get_artist

    my $artist = $mixcloud->get_artist( $url );

Returns a L<WWW::Mixcloud::Artist> object. C<$url> should be a valid artist URL.

=cut

sub get_artist {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Artist->new_from_data( $data );
}

=head2 get_track

    my $track = $mixcloud->get_artist( $url );

Returns a new L<WWW::Mixcloud::Track> object. C<$url> should be a valid track URL.

=cut

sub get_track {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Track->new_from_data( $data );
}

=head2 get_category

    my $category = $mixcloud->get_category( $url );

Returns a new L<WWW::Mixcloud::Category> object. C<$url> should be a valid
category URL.

=cut

sub get_category {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Category->new_from_data( $data );
}

sub _api_call {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $res = $self->ua->get( $API_BASE . $uri->path );

    if ( $res->is_success ) { 
        return decode_json $res->content;
    }
    else {
        warn 'API error';
    }
}

1;
