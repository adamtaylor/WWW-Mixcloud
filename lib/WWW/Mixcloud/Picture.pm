package WWW::Mixcloud::Picture;

use Moose;

has size => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has url => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

1;
