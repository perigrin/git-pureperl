package Git::PurePerl::Object::Tag;
use Moose;
use MooseX::StrictConstructor;
use Moose::Util::TypeConstraints;
extends 'Git::PurePerl::Object';

has 'kind' =>
    ( is => 'ro', isa => 'ObjectKind', required => 1, default => 'tag' );
has 'object'  => ( is => 'rw', isa => 'Str', required => 0 );
has 'tag'     => ( is => 'rw', isa => 'Str', required => 0 );
has 'tagger'  => ( is => 'rw', isa => 'Str', required => 0 );
has 'comment' => ( is => 'rw', isa => 'Str', required => 0 );

__PACKAGE__->meta->make_immutable;

sub BUILD {
    my $self = shift;
    my @lines = split "\n", $self->content;
    while ( my $line = shift @lines ) {
        last unless $line;
        my ( $key, $value ) = split ' ', $line, 2;
        next if $key eq 'type';
        $self->$key($value);
    }
    $self->comment( join "\n", @lines );
}

1;
