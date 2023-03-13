// Mounting bracket for ASIAir Plus with Synta base

$fa = 1;
$fs = 0.4;

arm_length = 110;
base_length = 40;
base_height = 9;

difference()
{
    rotate([ 90, 0, 0 ])
    {
        iso_trapazoid(short = 22.5, long = 32, length = base_length, height = base_height);
        translate([ 0, base_height, -(arm_length - base_length) ]) minkowski()
        {
            iso_trapazoid(short = 18.5, long = 20.5, length = arm_length - 1, height = 4);
            sphere(1);
        }
    }

    screw_hole(0, 40, 6, 4, 4, 7);
    screw_hole(0, 60, 6, 4, 4, 7);
}

// A counter-sunk screw hole
module screw_hole(x, y, h, d, ch, cd)
{
    translate([ x, y, h ]) cylinder(h, r = d / 2 + 0.2);
    translate([ x, y, h + ch ]) cylinder(h, r = cd / 2);
}

// 3D Isosceles Trapazoid
module iso_trapazoid(short, long, length, height, center = true)
{
    linear_extrude(length) translate([ center ? -long / 2 : 0, 0, 0 ])
        polygon(points = [ [ 0, 0 ], [ long / 2 - short / 2, height ], [ long / 2 + short / 2, height ], [ long, 0 ] ]);
}