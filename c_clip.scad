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
    translate([0, 0, -($height/2 + $tolerance/2)])
        pieSlice(70, $radius+$tolerance, $height+$tolerance);
}
