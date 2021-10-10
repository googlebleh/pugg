// rendering resolution
$fa = 1;
$fs = 0.4;

// always cut a little more than you need to
$tolerance = 0.1;

// clip parameters
$height = 6;
$diameter = 15;
$innerDiameter = 9;

module pieSlice(a, r, h) {
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
    $isocelesLeg = 20;
    $isocelesVertexAngle = 25;
    difference()
    {
        $shift = ($isocelesLeg - $diameter/2) / sqrt(2);
        // the slice
        translate([-$shift, -$shift, -($height/2 + $tolerance/2)])
            rotate(45 - $isocelesVertexAngle/2)
            pieSlice($isocelesVertexAngle, $isocelesLeg, $height+$tolerance);

        // don't cut out stuff in Q3
        $unit = 50;
        translate([-$unit, -$unit, -$unit/2])
            cube([$unit, $unit, $unit]);
    }
}
