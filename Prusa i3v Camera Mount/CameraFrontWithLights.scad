import("raspberri_pi_camera_case_front_v0.4.2.STL");

// X (despite being called depth)
casedepth = 29.8;

// Y (despite being called width)
casewidth = 28.8;

// Z
caseheight = 10;

translate([casedepth/2 - 12.5/2, 0, 0]) rotate([0, 0, -90]) Fingers();
translate([casedepth,casewidth/2,0]) LampMount();
translate([0,casewidth/2,0]) mirror([1,0,0]) LampMount();

module Fingers() {
	union() {
		Finger();
		translate([0, 5]) Finger();
		translate([0, 10]) Finger();
	}
} 

module Finger() {
	difference() {
		union() {
			translate([10, 2.5, 4]) rotate([90, 0, 0]) cylinder(h=2.5, d=8);
			translate([-2, 0, 0]) cube([12, 2.5, 8]);
			//translate([10, 0, 0]) cube([4, 2.5, 4]);
		}
		translate([10, 3, 4]) rotate([90, 0, 0]) cylinder(r=1.6, h=4, $fn=12);
	}
}

module LampMount() {
	difference() {
		union() {
			translate([-1.5,-7.75,0]) cube([8.5,15.5,9]);
			translate([-2,-7.75,0]) cube([8.5,15.5,1]);
			translate([7,0,0]) cylinder(d=15.5, h=9, $fn=36);
		}
		translate([7,0,0]) {
			cylinder(d=12.25, h=5, $fn=36);
			translate([0,0,5]) cylinder(d1=12.25, d2=10, h=2, $fn=36);
			translate([0,0,7]) cylinder(d=10, h=4, $fn=36);
		}
	}

}