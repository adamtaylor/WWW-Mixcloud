# ABSTRACT: Represents a cloudcast in the Mixcloud API
package WWW::Mixcloud::Cloudcast;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Cloudcast::Tag;
use WWW::Mixcloud::Cloudcast::Section;
use WWW::Mixcloud::Picture;
use WWW::Mixcloud::User;

=head1 ATTRIBUTES

=head2 listener_count

=cut

has listener_count => (
    is       => 'ro',
    required => 1,
);

=head2 name

=cut

has name => (
    is       => 'ro',
    required => 1,
);

=head2 tags

ArrayRef of L<WWW::Mixcloud::Cloudcast::Tag> objects.

=cut

has tags => (
    isa      => 'ArrayRef[WWW::Mixcloud::Cloudcast::Tag]',
    is       => 'ro',
    required => 1,
    default  => sub { [] },
    traits   => ['Array'],
    handles  => {
        add_tag        => 'push',
        all_tags       => 'elements',
        number_of_tags => 'count',
    },
);

=head2 url

=cut

has url => (
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
    traits   => ['Array'],
    handles  => {
        add_picture        => 'push',
        all_pictures       => 'elements',
        number_of_pictures => 'count',
    },
);

=head2 update_time

L<DateTime> object.

=cut

has update_time => (
    is       => 'ro',
    required => 1,
);

=head2 play_count

=cut

has play_count => (
    is       => 'ro',
    required => 1,
);

=head2 comment_count

=cut

has comment_count => (
    is       => 'ro',
    required => 1,
);

=head2 percentage_music

=cut

has percentage_music => (
    is       => 'ro',
    required => 1,
);

=head2 user

L<WWW::Mixcloud::User> object.

=cut

has user => (
    isa      => 'WWW::Mixcloud::User',
    is       => 'ro',
    required => 1,
);

=head2 key

=cut

has key => (
    is       => 'ro',
    required => 1,
);

=head2 created_time

=cut

has created_time => (
    is       => 'ro',
    required => 1,
);

=head2 audio_length

=cut

has audio_length => (
    is       => 'ro',
    required => 1,
);

=head2 sections

ArrayRef of L<WWW::Mixcloud::Cloudcast::Section> objects.

=cut

has sections => (
    isa      => 'ArrayRef[WWW::Mixcloud::Cloudcast::Section]',
    is       => 'ro',
    required => 1,
    default  => sub { [] },
    traits   => ['Array'],
    handles  => {
        add_section        => 'push',
        all_sections       => 'elements',
        number_of_sections => 'count',
    },
);

=head2 slug

=cut

has slug => (
    is       => 'ro',
    required => 1,
);

=head2 description

=cut

has description => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head1 METHODS

=head2 new_from_data

    my $cloudcast = WWW::Mixcloud::Cloudcast->new_from_data( $data )

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    my $user = WWW::Mixcloud::User->new_from_data( $data->{user} );
    my $tags = WWW::Mixcloud::Cloudcast::Tag->new_list_from_data( $data->{tags} );
    my $pictures = WWW::Mixcloud::Picture->new_list_from_data( $data->{pictures} );
    my $sections = WWW::Mixcloud::Cloudcast::Section->new_list_from_data(
        $data->{sections}
    );

    my $cloudcast = $class->new({
        listener_count   => $data->{listener_count},
        name             => $data->{name},
        tags             => $tags,
        url              => $data->{url},
        pictures         => $pictures,
        update_time      => DateTime::Format::Atom->parse_datetime( $data->{updated_time} ),
        play_count       => $data->{play_count},
        comment_count    => $data->{comment_count},
        percentage_music => $data->{percentage_music},
        user             => $user,
        key              => $data->{key},
        created_time     => DateTime::Format::Atom->parse_datetime( $data->{created_time} ),
        audio_length     => $data->{audio_length},
        sections         => $sections,
        slug             => $data->{slug},
        description      => $data->{description},
    });
}

1;
