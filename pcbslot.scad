// slot height = 3 5/16" = 84mm
cardHeight = 81;
// slot depth = 1 11/16" = 43mm
cardDepth = 43;
// slot width = 2mm
cardWidth = 1.7;
// pcb top = 6mm from slot top
pcbFromTop = 6;
// pcb height = 1 13/16" = 46mm
pcbHeight = 43;
// pcb depth = 1 5/16" = 33mm
pcbDepth = 33;
// pcb width = 2mm
pcbWidth = 3;

postFromTop = 24;
postGapSize = 13;

deepMaterialStart = pcbFromTop - 4;

difference() {
  union() {
    // most of the card
    cube(size = [cardHeight, cardWidth, cardDepth], center = false);
    // make deep only where the PCB goes
    translate([deepMaterialStart, cardWidth, 0]) {
      cube(size = [pcbHeight + pcbWidth * 4, pcbWidth, cardDepth], center = false);
    }
  }

  // make space for the posts
  translate([postFromTop, cardWidth, 0]) {
    cube(size = [postGapSize, pcbWidth, cardDepth]);
  }

  // remove some deep material to fit bottom slot
  translate([0, cardWidth * 2 + pcbWidth, 0]) {
    rotate([90, 0, 0]) {
      linear_extrude(height = cardWidth + pcbWidth, center = false) {
        polygon(points = [
          [deepMaterialStart, -1],
          [deepMaterialStart, cardDepth - pcbDepth - 2],
          [24, -1]],
          paths=[[0,1,2]]);
      }
    }
  }  

  // remove card body where pcb goes
  translate([pcbFromTop, 0, cardDepth - pcbDepth]) {
    cube(size = [pcbHeight, cardWidth + pcbWidth, pcbDepth], center = false);
  }

  // remove a little more to make a pcb slot
  translate([pcbFromTop - pcbWidth, cardWidth / 2, cardDepth - pcbDepth]) {
    cube(size = [pcbHeight + pcbWidth * 2, pcbWidth, pcbDepth], center = false);
  } 
}
