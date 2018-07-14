// Author: Charlie Snyder
// Twitter Handle: @mjrsnyder

$fn=30;

hole_spacing=154.94;
total_length=162;
bar_width=8;
bar_thickness=14;

hdd_hole_min_thickness=3;
hdd_hole_spacing=60+41.6;
hdd_countersink_diameter=9;

cutout_length_offset=13;

difference() {
    bar(bar_width, bar_thickness, hole_spacing);
    bar_holes(bar_thickness, hole_spacing);
    bar_cutout(cutout_length_offset, bar_width/2, hole_spacing, bar_thickness, bar_width);
    rotate(a=90, v=[1,0,0]){
      translate([(hole_spacing - hdd_hole_spacing)/2, bar_thickness/2, bar_width/2*-1]){
        hdd_holes(bar_width, 4, hdd_hole_spacing);
        hdd_countersink(hdd_countersink_diameter, bar_width, hdd_hole_min_thickness, hdd_hole_spacing);
      };
    };
};

module bar_cutout(length_offset, cutout_depth, hole_spacing, bar_thickness, bar_width) {
  length=hole_spacing - length_offset;
  diff=(hole_spacing - length)/2;
  translate([diff, cutout_depth/2 ,0]){
    cylinder(r=cutout_depth/2, h=bar_thickness);
  }
  translate([diff+length, cutout_depth/2 ,0]){
    cylinder(r=cutout_depth/2, h=bar_thickness);
  }
  difference(){
    translate([diff-(cutout_depth), cutout_depth/2 ,0]){
      cube([cutout_depth*2+length, cutout_depth/2, bar_thickness]);
    }

     translate([diff-(cutout_depth), cutout_depth/2 ,0]){
      cylinder(r=cutout_depth/2, h=bar_thickness);
    }

     translate([diff+length+(cutout_depth), cutout_depth/2 ,0]){
      cylinder(r=cutout_depth/2, h=bar_thickness);
    }
  }

  translate([diff, 0, 0]){
    cube([length, cutout_depth, bar_thickness]);
  }
}

module bar(width, thickness, hole_spacing) {
  translate([0, bar_width/2 * -1]){  
    cube([hole_spacing,bar_width,bar_thickness]);
  }
  cylinder(r=bar_width/2, h=bar_thickness);  
  translate([hole_spacing, 0]){
    cylinder(r=bar_width/2, h=bar_thickness);    
  };
};

module bar_holes(bar_thickness, hole_spacing) {
  cylinder(r=2, h=bar_thickness);
  translate([hole_spacing, 0]){
    cylinder(r=2, h=bar_thickness);    
  };  
}


module hdd_holes(hole_depth, hole_diameter, hdd_hole_spacing) {
  cylinder(r=hole_diameter/2, hole_depth+1);
  translate([hdd_hole_spacing, 0]){
    cylinder(r=hole_diameter/2, hole_depth+1);
  };
}

module hdd_countersink(diameter, total_depth, min_material, hole_spacing) {
  hole_depth=total_depth - min_material;
  cylinder(r=diameter/2, hole_depth);
  translate([hole_spacing, 0]){
    cylinder(r=diameter/2, hole_depth);
  };   
}