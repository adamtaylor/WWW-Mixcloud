package WWW::Mixcloud::Cloudcast::Section;

use Moose;

has track => (
    isa      => 'WWW::Mixcloud::Track',
    is       => 'ro',
    required => 1,
);

has name => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has position => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has start_time => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has section_type => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

1;
