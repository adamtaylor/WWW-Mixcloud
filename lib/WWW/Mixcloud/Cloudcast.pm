package WWW::Mixcloud::Cloudcast;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

use WWW::Mixcloud::Cloudcast::Tag;
use WWW::Mixcloud::Cloudcast::Section;
use WWW::Mixcloud::Picture;
use WWW::Mixcloud::User;

has listener_count => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has name => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

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

has url => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

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

has update_time => (
    isa      => 'DateTime',
    is       => 'ro',
    required => 1,
);

has play_count => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has comment_count => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has percentage_music => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has user => (
    isa      => 'WWW::Mixcloud::User',
    is       => 'ro',
    required => 1,
);

has key => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has created_time => (
    isa      => 'DateTime',
    is       => 'ro',
    required => 1,
);

has audio_length => (
    isa      => 'Int',
    is       => 'ro',
    required => 1,
);

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

has slug => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has description => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

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
