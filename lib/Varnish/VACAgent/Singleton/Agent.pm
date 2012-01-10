package Varnish::VACAgent::Singleton::Agent;

use 5.010;

use MooseX::Singleton;

use Data::Dumper;

use Varnish::VACAgent::ClientListener;
use Varnish::VACAgent::MasterListener;

with 'Varnish::VACAgent::Role::Configurable';
with 'Varnish::VACAgent::Role::Logging';



# has _cluster_manager => (
#     isa => 'Varnish::VACAgent::ClusterManager',
#     is => 'ro',
#     builder => '_build__cluster_manager',
# );
# 
# has _job_manager => (
#     isa => 'Varnish::VACAgent::JobManager',
#     is => 'ro',
#     builder => '_build__job_manager',
#);

has client_listener => (
    is         => 'rw',
    isa        => 'Varnish::VACAgent::ClientListener',
    builder => '_build_client_listener',
);

has master_listener => (
    is         => 'rw',
    isa        => 'Varnish::VACAgent::MasterListener',
    builder => '_build_master_listener',
);



sub _build_client_listener {
    my $self = shift;
    $self->debug("_build_client_listener");
    return Varnish::VACAgent::ClientListener->new();
}

sub _build_master_listener {
    my $self = shift;
    $self->debug("_build_master_listener");
    return Varnish::VACAgent::MasterListener->new();
}

sub BUILD {
    my $self = shift;

    $self->info("Waiting for incoming connections");
}



sub new_varnish_instance {
    my $self = shift;

    $self->info("Newly started varnish instance detected");
}



sub handle_varnish_request {
    my ($self, $data) = @_;

    $self->info("Received data: ", $data, " from varnish");
    return $data;
}



sub new_vac_client {
    my ($self, $client) = @_;

    $self->info("Accepted incoming VAC client connection from ",
                $client->remote_ip_address, "/", $client->remote_port);

}



sub handle_vac_client_request {
    my ($self, $data) = @_;

    $self->info("Received data: ", $data, " from VAC");
    return $data;
}




1;

__END__



=head1 AUTHOR

 Sigurd W. Larsen

=cut
