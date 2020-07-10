// n Number of corners
// r Radius in milimeters, like circle()
// c Corner radius in milimeters
// $fn Total number of sides, like circle()

module RoundedRegularPolygon(n, r, c=0){
	fn = (c<=0) ? n : max(n,ceil($fn)); // work with invalid `c` and `$fn`
	m = cos(180/n)*r; // Minor radius (origin to edge midpoint)
	i = (m-c)/cos(180/n); // Interior radius (origin to rounder center)
	as = (fn-n)/n; // Average number of exposed Sides per corner
	bs = floor(as); // Base number of exposed Sides per corner
	function ms(s) = floor(s*(as-bs)); // total # of Missing Sides from corner 0 to Some corner
	function es(s) = (ms(s)-ms(s-1) >= 1)?1:0; // Extra Sides on Some corner? (fix missing sides)
	hull(){
		for(j=[1:n]){
			rotate(j*360/n){
				intersection(){ // keep large rounders within their sector
					mx = m*cos(180/n); my = m*sin(180/n); // edge Midpoint X and Y
					polygon([[0,0],[mx,my],[r,0],[mx,-my]]); // sector of whole polygon
					s = bs + es(j); // exposed Sides this corner will have
					if (s<=0){
						polygon([[0,-0.1*i],[r,0],[0,0.1*i]]); // a point in an unrounded corner
					} else {
						translate([i,0]) rotate(180/n) circle(c, $fn=s*n); // a corner rounder
					}
				}
			}
		}
	}
} // Alex Von Hoene, 26 June 2020, cc0, alexvh.me
