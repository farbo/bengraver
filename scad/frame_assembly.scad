use <bar.scad>;
use <rod.scad>;
use <side.scad>;
use <x_table.scad>;
use <bottle.scad>;
use <bottle_driver.scad>;
use <../MCAD/motors.scad>;
use <timingPulley-v2.scad>;
include <dimensions.scad>;

x_table_bar_dist = 3;

// Sides
rotate([90,0,0]) side_r(span_bottom=span_bottom, span_bottle=span_bottle, t=board_thickness, back_tilt_angle=back_tilt_angle);
translate([0, width, 0]) rotate([90, 0, 0]) side_l();



// x table
translate([axle_position[0], 0, axle_position[1]])
rotate(table_tilt, [0,1,0]) translate([0,board_thickness+x_table_bar_dist,0]) x_table(width=width-board_thickness*2 - x_table_bar_dist*2);


// Bottle
translate([span_bottom, 0, 0])
  rotate([0, -back_tilt_angle, 0])
union() {
  translate([0,bottle_pos,span_bottle/2]) rotate(-90, [1,0,0]) bottle();
  // Bottle bar
  translate([0, bottle_bar_pos, 0]) bar(s=bottle_bar_height, width=bottle_bar_width, t=board_thickness, s_m=bottle_bar_height/2);

  // Rods
  translate([0,-board_thickness/2 - nut_t,0]) rod_threaded(l=width+board_thickness+nut_t*2);
  translate([0,-board_thickness/2 - nut_t,span_bottle]) rod_threaded(l=width+board_thickness+nut_t*2);
}

// Timing pulleys
 translate([bottle_axle_position[0], -board_thickness - 10, bottle_axle_position[1]]) rotate([90, 0, 0]) makeTimingPulley(numTeeth=63);
 translate([stepper_x, -board_thickness - 10, stepper_z]) rotate([90, 0, 0]) makeTimingPulley(numTeeth=8, hubHeight=0);