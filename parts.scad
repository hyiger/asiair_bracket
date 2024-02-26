$fa = 1;
$fs = 0.4;

// Used with intersect to slice a part into quarters
module quarter_slice(width, height, quarter = "")
{
    if (quarter == "0")
        translate([ 0, 0, 0 ]) cube([ width, width, height + 1 ]);
    if (quarter == "1")
        translate([ 0, -width, 0 ]) cube([ width, width, height + 1 ]);
    if (quarter == "2")
        translate([ -width, -width, 0 ]) cube([ width, width, height + 1 ]);
    if (quarter == "3")
        translate([ -width, 0, 0 ]) cube([ width, width, height + 1 ]);
}

// Text Label for OTA Adapter
module label(string, size, height, font = "Liberation Sans", halign = "center", valign = "center")
{
    linear_extrude(height)
    {
        text(text = string, size = size, font = font, halign = halign, valign = valign, $fn = 64);
    }
}

// Posts or holes to aid in aligning parts for gluing
module posts(x, z, h = 2, d = 2)
{
    stub_x = x / 2 + d * 2;
    for (x1 = [ -stub_x, stub_x ])
        translate([ x1, 0, z ]) cylinder(h = h, r = d);
}

// N - sided 3d polygon
module ngon3d(n, h, r)
{
    linear_extrude(height = h) circle(r = r, $fn = n);
}

// A thin ring
module ring(width, height, diameter)
{
    difference()
    {
        cylinder(h = height, d = diameter);
        cylinder(h = height + width + 1, d = diameter - width * 2, center = true);
    }
}

// 3D Isosceles Trapazoid
module iso_trapazoid(short, long, length, height, center = true)
{
    linear_extrude(length) translate([ center ? -long / 2 : 0, 0, 0 ])
        polygon(points = [ [ 0, 0 ], [ long / 2 - short / 2, height ], [ long / 2 + short / 2, height ], [ long, 0 ] ]);
}

module rounded_cylinder(h, r, n = 4)
{
    rotate_extrude(convexity = 1)
    {
        offset(r = n) offset(delta = -n) square([ r, h ]);
        square([ n, h ]);
    }
}

module rounded_square(width, r)
{
    hull()
    {
        translate([ -width / 2 + r, -width / 2 + r, 0 ]) circle(r);
        translate([ -width / 2 + r, width / 2 - r, 0 ]) circle(r);
        translate([ width / 2 - r, -width / 2 + r, 0 ]) circle(r);
        translate([ width / 2 - r, width / 2 - r, 0 ]) circle(r);
    }
}

module cap(diameter, thickness)
{
    translate([ 0, 0, -thickness ]) linear_extrude(thickness) for (i = [0:32])
    {
        rotate(i * 5, [ 0, 0, 1 ]) rounded_square(width = diameter - thickness, r = 2);
    }
}

// A counter-sunk screw hole
module screw_hole(x, y, h, d, ch, cd)
{
    translate([ x, y, h ]) cylinder(h, r = d / 2 + 0.2);
    translate([ x, y, h + ch ]) cylinder(h, r = cd / 2);
}

module tube(h, id, od)
{
    difference()
    {
        cylinder(h, r = od / 2);
        translate([ 0, 0, -0.5 ]) cylinder(h + 1, r = id / 2);
    }
}