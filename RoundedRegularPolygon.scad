// Make polygons (like circle($fn=n)) with rounded corners.
// Alex Von Hoene, 12 July 2020, cc0, alexvh.me

// n Number of corners
// r Radius in milimeters.
// c Corner radius in milimeters.
// $fn Total number of sides, like circle()
// $fa Angle between sides, like circle()
module RoundedRegularPolygon(n, r, c=0){
	fn = max(n, ($fn==0) ? 360/$fa : $fn); // valid>$fn>$fa
	m = cos(180/n)*r; // Minor radius (origin to edge midpoint)
	i = (m-c)/cos(180/n); // Interior radius (origin to circle center)
	as = (fn-n)/n; // Average number of exposed Sides per corner
	bs = floor(as); // Base number of exposed Sides per corner
	function ms(s) = floor(s*(as-bs)); // Missing Sides by Some corner
	function es(s) = floor(ms(s)-ms(s-1)); // Extra Side on corner?
	hull() for(j=[1:n]) rotate(j*360/n) intersection(){
		mx = m*cos(180/n); my = m*sin(180/n); // edge Midpoint X and Y
		polygon([[0,0],[mx,my],[r,0],[mx,-my]]); // sector of polygon
		s = bs + es(j); // visible Sides this corner will have
		// Not enough edges to round corner; put a point in it.
		if (s<=0) polygon([[0,-0.1*i],[r,0],[0,0.1*i]]);
		// Make a circle to round the corner
		else translate([i,0]) rotate(180/n) circle(c, $fn=s*n);
	}
}
