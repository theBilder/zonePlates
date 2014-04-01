//********************************************
//This code is provided under a Creative Commons Attribution license. Feel free to use it any way you like, but please retain this comment header
//Q. Tyrell Davis
//Questions?--> thebilder.wordpress.com
//https://creativecommons.org/
//CC BY
//********************************************

//Parameters
lambda = 550*pow(10,-3); 
//wavelength of light (in mm). Taken as an average green here. 

zones = 15; 
//number of zones. With too many zones the width of each zone will be too thin for practical fabrication

focal = 80; 
//the focus distance for the zone plate

strutWidth = .75;
//width of the struts holding the zone plate rings

fineness = 68; 
//determines how smooth the circles are

random = 1;
// 0 for ordered placement, 1 for random struts. Ordered placement will result in diffraction spikes

uiStruts = 4; 
//Number of struts holding zones in place
//End parameters 
//Formulae used to define the zone plate are from en.wikipedia.org/wiki/Zone_plate

vRand = random * rands(0,1,uiStruts*zones);
plateRadius = sqrt((zones+1)*focal*lambda)+2; //sqrt((zones)*focal*lambda+(pow(n,2)*pow(lambda,2))/4);

//uncomment to echo the thinnest ring width
echo("thinnest ring = ",sqrt((zones)*focal*lambda+(pow(zones,2)*pow(lambda,2))/4)-sqrt((zones-1)*focal*lambda+(pow((zones-1),2)*pow(lambda,2))/4));
//echo("plate radius = ",plateRadius);

//uncomment to echo the approx resolution
//echo(sqrt((zones)*focal*lambda+(pow(zones,2)*pow(lambda,2))/4)-sqrt((zones-1)*focal*lambda+(pow((zones-1),2)*pow(lambda,2))/4));

/
//Building the zone plate
difference(){
circle(r=plateRadius,$fn=fineness);
//translate([-55,-27.5]) square([85,55]); //comment the circle above and uncomment this to make a business card

for(n = [0:2:zones]){
union(){
difference(){
circle(r= sqrt((n)*focal*lambda+(pow(n,2)*pow(lambda,2))/4),$fn = fineness);
circle(r= sqrt((n-1)*focal*lambda+(pow(n,2)*pow(lambda,2))/4),$fn = fineness);

for(k = [1:uiStruts]){
rotate([0,0,(vRand[k*n-1])*360/uiStruts+k*360/uiStruts]){
translate([-.1+sqrt((n-1)*focal*lambda+(pow(n,2)*pow(lambda,2))/4),0,0]){
square([sqrt((n)*focal*lambda+(pow(n,2)*pow(lambda,2))/4),strutWidth],center = true);
}//translate
}//rotate
}//for

}//difference
}//union
}//for

}//difference

