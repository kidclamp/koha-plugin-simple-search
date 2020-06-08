package Koha::Plugin::Com::ByWaterSolutions::SimpleSearch::Controller;

# This file is part of Koha.
#
# Koha is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation; either version 3 of the License, or (at your option) any later
# version.
#
# Koha is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with Koha; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

use Modern::Perl;

use Mojo::Base 'Mojolicious::Controller';

=head1 API

=head2 Class Methods

=head3 Method that searches Koha

=cut

sub search {
    my $c = shift->openapi->valid_input or return;

    my $query = $c->validation->param('query');
    my $offset = $c->validation->param('offset');
    my $max_results = $c->validation->param('maxx_results');
    my $plugin   = Koha::Plugin::Com::ByWaterSolutions::SimpleSearch->new();
    my $results = $plugin->simple_search( $query, $offset, $max_results );

    unless ($query) {
        return $c->render( status => 404, openapi => { error => "No query." } );
    }

    return $c->render( status => 200, json => $results );
}

1;
