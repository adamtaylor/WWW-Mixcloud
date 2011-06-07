package WWW::Mixcloud::Cloudcast;

use Moose;

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
    isa      => 'ArrayRef[WWW::Mixcloud::Cloudcast::Tag]'
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

1;
