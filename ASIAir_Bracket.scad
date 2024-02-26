// Mounting bracket for ASIAir Plus with Synta base

include <parts.scad>

// Arm that attached to the ASIAir
arm_length = 110;
arm_thickness = 4;
arm_text = "RedCat 71";
base_length = 40;
base_height = 9;

// Screw holes
screw_offset = 40;
screw_size = 4;
screw_length = 6;
head_depth = 4;
head_size = 7;

// Synta Bracket
bracket_long = 32;
bracket_short = 22.5;

difference()
{
    rotate([ 90, 0, 0 ])
    {
        // Synta bracket
        iso_trapazoid(short = bracket_short, long = bracket_long, length = base_length, height = base_height);

        // Mounting arm
        translate([ 0, base_height, -(arm_length - base_length) ]) minkowski()
        {
            iso_trapazoid(short = bracket_short - 4, long = bracket_short - 2, length = arm_length - 1,
                          height = arm_thickness);
            sphere(1);
        }
    }

    // Screw holes for mounting the ASIAir
    screw_hole(0, screw_offset, screw_length, screw_size, head_depth, head_size);
    screw_hole(0, screw_offset + 20, screw_length, screw_size, head_depth, head_size);
}

// Apply text to top of arm
translate([ 0, 0, base_height + arm_thickness ]) rotate([ 0, 0, 90 ]) label(string = arm_text, size = 8, height = 2);