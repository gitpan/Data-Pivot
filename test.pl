# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use Data::Pivot;
ok(1); # If we made it this far, we're ok.

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

my @table = ( [ 'a', 'b', 'c', 1, 10 ],
              [ 'a', 'b', 'c', 2, 20 ],
              [ 'a', 'b', 'c', 3, 30 ],
              [ 'x', 'y', 'z', 1, 1 ],
              [ 'x', 'y', 'z', 2, 2 ],
              [ 'x', 'y', 'z', 3, 3 ],
            );
my @headings = ( 'A', 'B', 'C', 'P', 'V' );
my @fix_cols = ( 0, 1, 2 );
my $pivot_col = 3;
my @sum_cols = ( 4 );

print "Before:\n";
out(\@headings, \@table);
my @newtable = pivot( table        => \@table, 
                      headings     => \@headings, 
                      fix_columns  => \@fix_cols, 
                      pivot_column => $pivot_col, 
                      sum_columns  => \@sum_cols,
                      row_sum      => 0,
                      row_titles   => 0,
                      format       => '%5.2f'
                    );
print "\nAfter:\n";
out(\@headings, \@newtable);
                      

@table = ( [ 'a', 'b', 'c', 1, 10, 1, 12 ],
           [ 'a', 'b', 'c', 2, 20, 2, 24 ],
           [ 'a', 'b', 'c', 3, 30, 3, 36 ],
           [ 'x', 'y', 'z', 1, 1, 9, 23 ],
           [ 'x', 'y', 'z', 2, 2, 8, 34 ],
           [ 'x', 'y', 'z', 3, 3, 7, 45 ],
         );
@headings = ( 'A', 'B', 'C', 'P', 'V1', 'V 2', 'V  3' );
@fix_cols = ( 0, 1, 2 );
$pivot_col = 3;
@sum_cols = ( 4, 5, 6 );

print "\n\nBefore:\n";
out(\@headings, \@table);
@newtable = pivot( table        => \@table, 
                      headings     => \@headings, 
                      fix_columns  => \@fix_cols, 
                      pivot_column => $pivot_col, 
                      sum_columns  => \@sum_cols,
                      row_sum      => 'Sum',
                      row_titles   => 1,
                      format       => '%5.2f'
                    );
print "\nAfter:\n";
out(\@headings, \@newtable);

sub out {
  my ($headings, $table) = @_;

	print $_, "\t" foreach @$headings;
	print "\n\n";
	foreach (@$table) {
		print $_, "\t" foreach @$_;
		print "\n";
	}
}
