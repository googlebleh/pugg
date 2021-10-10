// rendering resolution
$fa = 1;
$fs = 0.4;

// always cut a little more than you need to
$tolerance = 0.1;

// clip parameters
$height = 6;
$diameter = 15;
$innerDiameter = 9;

module pieSlice(a, r, h){
  // a:angle, r:radius, h:height
  rotate_extrude(angle=a)
    square([r,h]);
}

difference()
{
    $radius = $diameter/2;

    // create outer circle
    cylinder(r=$radius, h=$height, center=true);

    // delete inner circle
    cylinder(r=$innerDiameter/2, h=$height+$tolerance, center=true);

    // cut out a slice
    difference()
    {
        $shift = (20 - $diameter/2) / sqrt(2);
        // the slice
        translate([-$shift, -$shift, -($height/2 + $tolerance/2)])
        rotate(45-12.5)
            pieSlice(25, 20, $height+$tolerance);

        // don't cut out stuff in Q3
        translate([-50, -50, -25])
          cube([50, 50, 50]);
    }
}
