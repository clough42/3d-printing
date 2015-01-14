// RAMPS Fan Mount
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com> and contributors
// visit: http://www.schlotzz.com


module ramps_fan_mount_cutoff_cube(width, height, depth, cutoff = 5, radius = 5)
{
	union()
	{
		cube([width, height - cutoff - radius, depth]);

		hull()
		{
			for (x = [radius, width - radius])
				translate([x, height - cutoff - radius, 0])
					cylinder(r = radius, h = depth);
	
			for (x = [radius + cutoff, width - radius - cutoff])
				translate([x, height - radius, 0])
					cylinder(r = radius, h = depth);
		}
	}
}


module ramps_fan_mount(width = 64, height = 40, depth = 10, fanDia = 40, fanHoleDia = 2.4, fanHoleDist = 32, grooveDepth = 1.5, grooveHeight = 2.5, thickness = 3.5, airGuide = 1.5, bossDia = 8, $fn = 16)
{
	difference() 
	{
		union() 
		{
			difference()
			{
				// base corpus
				ramps_fan_mount_cutoff_cube(width, height, depth, cutoff = 4.5, radius = 5);
		
				// hollow, leave side air guide
				translate([thickness, -thickness, airGuide]) {
					ramps_fan_mount_cutoff_cube(width - 2 * thickness, height, depth + 2, cutoff = 	4.1, radius = 2.5);	
				}
		
				// remove unneeded air guide
				translate([thickness, -1, -1])
					cube([width - 2 * thickness, height - thickness - 8, depth + 2]);
		
				// add grooves
				translate([thickness - grooveDepth, 2, -1])
					cube([width - 2 * thickness + grooveDepth * 2, grooveHeight, depth + 2]);

				// smaller legs
				translate([-1, height / 2 - depth, depth * 1.5])
					rotate([0, 90, 0])
						cylinder(r = depth, h = width + 2);
				translate([-1, -1, depth / 2])
					cube([width + 2, height / 2 - depth + 1, depth / 2 + 1]);
		
			}
		
			// fan screw bosses
			for (x = [(width - fanHoleDist) / 2, (width + fanHoleDist) / 2])
				translate([x, height + 0, depth / 2])
					rotate([90, 0, 0])
						cylinder(r = bossDia / 2, h = thickness + 2);
		}
		
		
		// fan mounting holes
		for (x = [(width - fanHoleDist) / 2, (width + fanHoleDist) / 2])
			translate([x, height + 1, depth / 2])
				rotate([90, 0, 0])
					cylinder(r = fanHoleDia / 2, h = thickness + 4);
		
		// fan hole
		translate([width / 2, height + 1, depth / 2 + fanHoleDist / 2])
			rotate([90, 0, 0])
				cylinder(r = fanDia / 2 - 1, h = thickness + 10);
		

	}
	
}
	
ramps_fan_mount($fn = 32);