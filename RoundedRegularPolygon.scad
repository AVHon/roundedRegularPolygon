// n Number of corners
// r Radius in milimeters, like circle()
// c Corner radius in milimeters
// $fn Total number of sides, like circle()

module RoundedRegularPolygon(n, r, c=0){
	fn = max(n, ($fn==0) ? 360/$fa : $fn); // valid>$fn>$fa
	m = cos(180/n)*r; // Minor radius (origin to edge midpoint)
	i = (m-c)/cos(180/n); // Interior radius (origin to rounder center)
	as = (fn-n)/n; // Average number of exposed Sides per corner
	bs = floor(as); // Base number of exposed Sides per corner
	function ms(s) = floor(s*(as-bs)); // Missing Sides from corners [0:Some]
	function es(s) = (ms(s)-ms(s-1) >= 1)?1:0; // Extra Side on Some corner?
	hull() for(j=[1:n]) rotate(j*360/n) intersection(){
		mx = m*cos(180/n); my = m*sin(180/n); // edge Midpoint X and Y
		polygon([[0,0],[mx,my],[r,0],[mx,-my]]); // sector of whole polygon
		s = bs + es(j); // visible Sides this corner will have
		if (s<=0){ // a point in an unrounded corner
			polygon([[0,-0.1*i],[r,0],[0,0.1*i]]);
		} else { // a circle to round the corner
			translate([i,0]) rotate(180/n) circle(c, $fn=s*n);
		}
	}
} // Alex Von Hoene, 12 July 2020, cc0, alexvh.me
